const express = require('express');
const authRoute = express.Router();
const sql = require('mssql');
const { Database } = require('../database_access/database_access');
const db = new Database();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { WalletRoute } = require('../wallet_access_route/wallet_api');

authRoute.use(express.json());

authRoute.get('/check', (req, res, next) => {
    return res.status(200).send('Authentication route working perfectly');
});

authRoute.post('/register', async (req, res, next) => {
    try {
        const { username, email, password } = req.body;
        if (username && email && password) {
            const rounds = 10;
            const salt = await bcrypt.genSalt(rounds);
            const hashedPassword = await bcrypt.hash(password, salt);
            req.hashedPassword = hashedPassword;
            console.log(hashedPassword);
            next();
        }
        else {
            return res.status(400).send('all the properties should be in the request body');
        }
    } catch (err) {
        return res.status(400).json({ 'error': err.message });
    }
}, async (req, res, next) => {
    try {
        const { username, email } = req.body;

        const query = "INSERT INTO users(username, email, password) VALUES (@username, @email, @password)";

        await db.executeQuery(query, {
            "username": { "type": sql.VarChar, "value": username },
            "email": { "type": sql.VarChar, "value": email },
            "password": { "type": sql.VarChar, "value": req.hashedPassword },
        });

        next();

    } catch (err) {
        return res.status(400).json({ 'error': err.message });
    }
}, async (req, res) => {
    try {
        const query = `UPDATE addresses 
        SET username = @username 
        WHERE username IS NULL 
        AND address = (SELECT TOP 1 address FROM addresses WHERE username IS NULL)`;
        await db.executeQuery(query, {
            'username': {
                'type': sql.VarChar,
                'value': req.body.username
            }
        });

        return res.status(200).send("successfully resgistered");

    } catch (err) {
        return res.status(400).json({ "error": err.message });
    }
});

authRoute.post('/login', async (req, res, next) => {
    const { email, password } = req.body;
    if (email && password) {
        const verifyMail = 'SELECT email FROM users';
        const emails = await db.executeQuery(verifyMail);
        const isExists = emails.some(mail => mail.email === email);

        if (isExists) {
            const query = 'SELECT username,password FROM users WHERE email=@email';
            const result = await db.executeQuery(query, {
                "email": {
                    "type": sql.VarChar,
                    "value": email
                }
            });
            req.username = result[0]['username'];
            if (result) {
                const isSame = await bcrypt.compare(password, result[0]['password']);
                if (isSame) {
                    return next();
                }
                return res.status(403).json({ "error": "Incorrect password" });
            }
        }
        return res.status(400).json({ "message": "email not found" });
    }
}, async (req, res) => {
    try {
        const payload = { 'username': req.username, 'email': req.body.email };
        const token = jwt.sign(payload, process.env.SECRET_KEY, { expiresIn: "1d" });
        return res.status(200).json({ 'message': { "token": token } });
    } catch (err) {
        return res.status(400).json({ "error": err.message });
    }
});

authRoute.use('/verify', async (req, res, next) => {
    try {
        const header= req.headers['authorization'];
        let token;
        if(header){
            if(header.startsWith('Bearer')){
                token=header.split(" ")[1];
                jwt.verify(token,process.env.SECRET_KEY,(err,decoded)=>{
                    if(err){
                        return res.status(400).json({"error":err.message});
                    }
                    req.username = decoded['username'];
                    console.log(decoded['username']);
                    return next();
                });
            }
            else{
            return res.status(400).send('Not a Bearer token');
            }
        }
    } catch (err) {
        return res.status(400).json({ "error": err.message });
    }
});


module.exports.authRoute = authRoute;
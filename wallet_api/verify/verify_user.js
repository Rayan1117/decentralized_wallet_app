const express = require('express');
const UserVerification = express.Router();
const sql = require('mssql');
const { Database } = require('../database_access/database_access');
const db = new Database();

UserVerification.get('/check', (req, res) => {
    return res.status(200).send('verification route working perfectly');
});

UserVerification.use( async (req, res, next) => {
    try {
        const address = req.body.recipient;
        const sender=req.headers['address'];
        if(address==sender){
            return res.status(400).json({"error":"can't transfer amount to your own account"});
        }
        const query = "SELECT username from addresses WHERE address = @address";
        const user = await db.executeQuery(query, {
            "address": {
                "type": sql.Char,
                "value": address
            }
        },
        );

        if (user.length!==0) {
            if(user[0]['username']){
                return next();
            }
            
        }
        return res.status(400).json({ "error": "user not found" });

    } catch (err) {
        return res.status(500).json({ "error": err.message });
    }
});

module.exports.UserVerification= UserVerification;
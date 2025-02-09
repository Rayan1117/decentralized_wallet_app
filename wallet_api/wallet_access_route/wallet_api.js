const express = require('express');
const walletRoute = express.Router();
const { WalletAccess } = require('../wallet_access');
const WA = new WalletAccess();
const { UserVerification }=require('../verify/verify_user');

walletRoute.use(express.json());

walletRoute.get('/check', (req, res) => {
    return res.status(200).send('wallet route working perfectly');
});

walletRoute.use('/verify_user',UserVerification);

walletRoute.get('/get_balance', async (req, res) => {
    try {
        const address = req.headers['address'];
        if (address) {
            const balance = await WA.getBalanceOf(address);
            return res.status(200).json({ 'balance': balance.toString() });
        }
        return res.status(400).send('User Address not found');

    } catch (err) {
        return res.status(200).json({ 'error': err.message });
    }
});

walletRoute.post('/verify_user/transfer', async (req, res) => {
    try {
        const address = req.headers['address'];
        if (address) {
            const recipientAddress = req.body.recipient;
            if (recipientAddress) {
                const amount = req.body.amount;
                await WA.transfer(amount, address, recipientAddress);
                return res.status(200).send('transfer successful');
            }
            return res.status(400).send("reciepient address not found");
        }
        return res.status(400).send('User Address not found');
    } catch (err) {
        return res.status(400).json({ "error": err.message });
    }
});

walletRoute.post('/initialize', async (req, res) => {
    try {
        const address = req.headers['address'];
        if (address) {
            const result = await WA.initializeWallet(address);
            if (result === 'wallet initialized') {
                return res.status(200).json({ "message": result });
            }
            throw result;
        }
    } catch (err) {
        return res.status(400).json({ "error": err.message });
    }
});

module.exports.WalletRoute = walletRoute;
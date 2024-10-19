require('dotenv').config();
const express = require ('express');
const app=express();
const PORT=process.env.PORT;
const { WalletRoute }=require('./wallet_access_route/wallet_api');
const { authRoute }=require('./auth_route/auth_route');


app.use('/wallet/auth/verify',WalletRoute);

app.use('/auth',authRoute);

app.get('/',(req,res)=>{
    return res.status(200).send('request recieving successfully');
});

app.listen(PORT,()=>{
    console.log(`running at http://localhost:${PORT}`);
});
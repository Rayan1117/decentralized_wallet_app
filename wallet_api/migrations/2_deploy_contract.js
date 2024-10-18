const walletContract=artifacts.require('Wallet');

module.exports = (deployer)=>{
    deployer.deploy(walletContract);
}
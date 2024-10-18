const { Web3 } = require('web3');
const { abi } = require('C:\\Users\\rayan\\decentralized_wallet_app\\wallet_api\\build\\contracts\\Wallet.json');

class WalletAccess {
    constructor() {
        this.ethNetwork = new Web3('http://127.0.0.1:7545');
        this.contractAddress = '0xCEd2D3e48660f91Eb306FA1B545569Dbe3c3e4eA';
        this.contract = new this.ethNetwork.eth.Contract(abi, this.contractAddress);
    }

    async initializeWallet(address) {
        try {
            await this.contract.methods.initializeWallet(address).send(
                {
                    from: address,
                    gas: 300000,
                }
            );
            return 'Wallet initialized';
        } catch (err) {
            return err.message;
        }
    }

    async transfer(amount, senderAddress, receiverAddress) {
        try {
            await this.contract.methods.transfer(amount, receiverAddress).send({
                from: senderAddress,
                gas: 500000,
            });
            return 'Transfer successful';
        } catch (err) {
            return err.message;
        }
    }

    async getBalanceOf(address) {
        try {
            const balance = await this.contract.methods.getBalanceOf(address).call();
            return balance;
        } catch (err) {
            return err.message;
        }
    }

}

module.exports.WalletAccess=WalletAccess
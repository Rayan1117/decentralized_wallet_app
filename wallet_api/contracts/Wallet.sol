// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    mapping(address => uint) public balance;

    event Update(address sender,uint amount);
    
    function initializeWallet(address user) public {
        require(balance[user] == 0, "Already initialized");
        balance[user] = 1000;
    }

    modifier isInitialized(address sender) {
        require(balance[sender] > 0, "Sender balance is not initialized yet");
        _;
    }

    function transfer(uint amount, address receiver) public isInitialized(msg.sender) payable{
        require(balance[msg.sender] >= amount, "Insufficient balance");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
    }

    function getBalanceOf(address user) public view returns (uint) {
        return balance[user];
    }
}

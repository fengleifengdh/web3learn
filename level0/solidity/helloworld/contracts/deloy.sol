// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Event {
    address ownerAddress;
    constructor(){
        ownerAddress = msg.sender;
    }
        //合约地址
    function getContractAddress() external view  returns (address){
        return address(this);
    }
    //调用合约地址
    function getSenderAddress() external view  returns (address){
        return msg.sender;
    }
    //合约拥有者的地址
    function getOwnerAddress() external view returns (address)  {
        return ownerAddress;
    }

    function getBalance() external view returns (uint,uint,uint)  {

        uint contractBalance = address(this).balance;
                uint senderBalance = msg.sender.balance;

        uint wonerBalance = ownerAddress.balance;

        return (contractBalance,senderBalance,wonerBalance);
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Call {

    function send(address payable _to) public  payable {
        bool isSend = _to.send(msg.value);
        require(isSend,"send fail");
    }

    
    function transfer(address payable _to) public  payable {
       _to.transfer(msg.value);
        // require(isSend,"send fail");
    }

    function call(address payable _to) public  payable {
      (bool isSend,)  = _to.call{value:msg.value,gas:5000}("");
        require(isSend,"send fail");
    }
}
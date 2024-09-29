// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Receiver {



    event Received(address caller ,uint amount,string message);

    receive() external payable { 
                emit Received(msg.sender,msg.value,"receive was called");
    }
    fallback() external payable { 
                        emit Received(msg.sender,msg.value,"fallback was called12312");
    }

    function getAddress() public view  returns (address) {

        return address(this);
    }

    function foo(string memory _message ,uint256 _y) public payable  returns (uint){
                                emit Received(msg.sender,msg.value,_message);
        return _y;
    }  
 

    function getBalance() public view  returns (uint) {
        return address(this).balance;
    }
}

contract Caller{
    Receiver receiver;
    constructor(){
        receiver = new Receiver();
    }
    event Response(bool success,bytes data);
    function testCall(address payable _addr,uint _y) public payable {
        // (bool success,bytes memory data) = _addr.call{value:msg.value}("");
                // (bool success,bytes memory data) = _addr.call{value:msg.value}("flf");
        (bool success,bytes memory data) = _addr.call{value:msg.value}(abi.encodeWithSignature("foo(string,uint256)","call foo",_y));

        emit Response(success,data);
    }

        function getAddress() public view  returns (address) {

        return receiver.getAddress();
    }
 

    function getBalance() public view  returns (uint) {

        return receiver.getBalance();
    }
}
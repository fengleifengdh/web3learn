// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract HelloWorld {
    string public greet = "Hello Worldflf!";

    function set(string memory message ) public {
        greet = message;
    }
     function get() public view returns (string memory){
        return greet;
    }
}
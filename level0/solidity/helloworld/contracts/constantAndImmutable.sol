// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Event {
    //赋值初始化
    string constant name = "Biden";
    //纸可以赋值一次
    uint immutable age;

    constructor(){
        age = 100;
    }
    function getName() public pure returns(string memory){
        return name;
    }

        function getAge() public view returns(uint ){
        return age;
    }
}
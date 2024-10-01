// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


abstract contract Base2{
    string public name = "test";
    function getFirstName() external pure virtual returns(string memory);
        function getLastName() external pure virtual returns(string memory);

}

interface Base{
    function getFirstName() external pure returns(string memory);
        function getLastName() external pure returns(string memory);

}
contract Event is Base {


 function getFirstName() external pure returns(string memory){
    return "amazing";
 }
        function getLastName() external pure returns(string memory){
            return "flf";
        }




}
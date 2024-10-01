// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {
    }
}
// contract Event {



//     event Deposit(address _from ,string _name,uint256 _value);
//     function deposit(string memory _name) public payable {
//         emit Deposit(msg.sender,_name,msg.value);
//     }
//     // address public owner;
//     // uint256 public account;
//     // constructor (){
//     //     owner = msg.sender;
//     //     account = 0;
//     // }
//     // // modifier onlyOwner(uint256 _account){
//     // //     require(msg.sender == owner,"only");
//     // // }

//     // modifier onlyOwner(uint256 _account){
//     //     require(msg.sender == owner,"only");
//     //     _;
//     // }
//     // function updateAccount(uint256 _account)public onlyOwner(_account){
//     //     account = _account  ;
//     // }


// }
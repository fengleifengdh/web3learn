// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract God{
    event Log(string message);
    function foo() public virtual{
        emit Log("god foo message");
    }
        function bar() public virtual{
        emit Log("god bar message");
    }
}

contract Adam is God{
    function foo() public  virtual  override {
                emit Log("Adam.foo called");
        super.foo();
    }
        function bar() public  virtual  override {
                emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract people is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
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
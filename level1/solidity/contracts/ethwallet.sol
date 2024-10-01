// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// import "@rari-capital/solmate/src/tokens/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthWallet  {


    address payable public immutable owner;
    event Log(string funName, address from, uint256 value, bytes data);

    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    function whitDraw() external {
        require(msg.sender == owner," not woner");
        payable(msg.sender).transfer(100);
    }

    function whitDraw2() external {
        require(msg.sender == owner," not woner");
        bool success = payable(msg.sender).send(100);
        require(success, "Send Failed");

    }
    
    function whitDraw3() external {
        require(msg.sender == owner," not woner");
        (bool success, ) = msg.sender.call{value:address(this).balance}("");
        require(success, "Send Failed");
    }
    // event Deposit(address _from,uint256 amount);
    // event Withdraw(uint256 amount);
    // // constructor() ERC20("Wrapped Ether","WETH",18) {}
    // constructor() ERC20("Wrapped Ether","WETH"){}
    // receive() external payable { 
    //     emit Deposit(msg.sender,msg.value);
    // }
    // fallback() external payable {
    //     deposit();
    // }
    // function deposit() public  payable {
    //     _mint(msg.sender,msg.value);
    //     emit Deposit(msg.sender,msg.value);
    // }
    // function withdraw(uint _amount) public  payable {
    //     _burn(msg.sender,_amount);
    //     payable(msg.sender).transfer(_amount);
    //     emit Withdraw(_amount);
    // }

    // // constructor() payable {
    // //     owner = msg.sender;
    // // }
    

    // // 方法
    // function withdraw() external {
    //     require(msg.sender == owner, "Not Owner");
    //     emit Withdraw(address(this).balance);
    //     selfdestruct(payable(msg.sender));
    // }

    // function getBalance() external view returns(uint256){
    //     return address(this).balance;
    // }
}
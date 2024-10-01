// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Bank {
    
    address public immutable owner;

    event Deposit(address _from,uint256 amount);
    event Withdraw(uint256 amount);
    receive() external payable { 
        emit Deposit(msg.sender,msg.value);
    }
    constructor() payable {
        owner = msg.sender;
    }
    

    // 方法
    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}
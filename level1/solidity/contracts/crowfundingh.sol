// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// import "@rari-capital/solmate/src/tokens/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract crowdFunding  {


    address public immutable beneficiary;
    uint256 public immutable fundingGoal;

    uint256 public fundingAmount;
    mapping(address=>uint) public funders;
    mapping(address=>bool) private fundersInserted;
    address[] public fundersKey; // length


    bool public AVAILABLED = true; // 状态
    constructor(address _beneficiary,uint256 _goal){
        beneficiary = _beneficiary;
        fundingGoal = _goal;
    }

    function contribute() external payable {
        require(AVAILABLED,"  is close");
        uint256 protentialFundingAmount = fundingAmount + msg.value;
        uint256 refundAmount = 0;
        if(protentialFundingAmount > fundingGoal){
            refundAmount = protentialFundingAmount - fundingGoal;
        }
        fundingAmount +=(msg.value -refundAmount);
        funders[msg.sender] +=(msg.value-refundAmount);


        if(!fundersInserted[msg.sender]){
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }
        if(refundAmount > 0){
            payable(msg.sender).transfer(refundAmount);
        }
    }


    // 关闭
    function close() external returns(bool){
        // 1.检查
        if(fundingAmount<fundingGoal){
            return false;
        }
        uint256 amount = fundingAmount;
        // 2.修改
        fundingAmount = 0;
        AVAILABLED = false;
        // 3. 操作
        payable(beneficiary).transfer(amount);
        return true;
    }

    function fundersLenght() public view returns(uint256){
        return fundersKey.length;
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

    // constructor() payable {
    //     owner = msg.sender;
    // }
    

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
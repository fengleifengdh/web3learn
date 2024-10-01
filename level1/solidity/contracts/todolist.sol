// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// import "@rari-capital/solmate/src/tokens/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TODOLIST  {

    struct todo{
        string name;
        bool isCompleted;
    }
    todo[] public list;

    function create(string memory _name) external {
        list.push(todo({
            name:_name,
            isCompleted:false
        }));
    }

    function changeName(uint256  _index,string memory tarageName) public {
        list[_index].name = tarageName;
    }
    function modiName2(uint256 index_,string memory _name) external {
        // 方法2: 先获取储存到 storage，在修改，在修改多个属性的时候比较省 gas
        todo storage temp = list[index_];
        temp.name  = _name;
    }
        // 修改完成状态1:手动指定完成或者未完成
    function modiStatus1(uint256 index_,bool status_) external {
        list[index_].isCompleted = status_;
    }
        // 修改完成状态2:自动切换 toggle
    function modiStatus2(uint256 index_) external {
        list[index_].isCompleted = !list[index_].isCompleted;
    }
        // 获取任务1: memory : 2次拷贝
    // 29448 gas
    function get1(uint256 index_) external view
        returns(string memory name_,bool status_){
        todo memory temp = list[index_];
        return (temp.name,temp.isCompleted);
    }
      // 29388 gas
    function get2(uint256 index_) external view
        returns(string memory name_,bool status_){
        todo storage temp = list[index_];
        return (temp.name,temp.isCompleted);
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
    

    // // // 方法
    // function withdraw() external {
    //     require(msg.sender == owner, "Not Owner");
    //     emit Withdraw(address(this).balance);
    //     selfdestruct(payable(msg.sender));
    // }

    // function getBalance() external view returns(uint256){
    //     return address(this).balance;
    // }
}
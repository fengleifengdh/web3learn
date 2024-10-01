// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// import "@rari-capital/solmate/src/tokens/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract wallet  {

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public required;
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool exected;
    }
    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public approved;

    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);
    // receive
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
        // 函数修改器
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }
    modifier txExists(uint256 _txId) {
        require(_txId < transactions.length, "tx doesn't exist");
        _;
    }
    modifier notApproved(uint256 _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }
    modifier notExecuted(uint256 _txId) {
        require(!transactions[_txId].exected, "tx is exected");
        _;
    }

    constructor(address[] memory _owners,uint256 _required){
        require(_owners.length>0,"owner required");
        require(_required >0 && _required<= _owners.length," required num is error");
        for (uint256 index = 0;index<_owners.length;index ++){
            address owner = _owners[index];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique"); // 如果重复会抛出错误
            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }
        // 函数
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    function submit(
        address _to,   
        uint256 _value,
        bytes calldata _data
    ) external onlyOwner returns(uint256){

        transactions.push(
            Transaction({
                to :_to,
                value :_value,
                data :_data,
                exected : false
            })
        );
        emit Submit(transactions.length - 1);
        return transactions.length -1;
    }

    function approv(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }


    function execute(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(getApprovalCount(_txId) >= required, "approvals < required");
        Transaction storage transaction = transactions[_txId];
        transaction.exected = true;
        (bool sucess, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(sucess, "tx failed");
        emit Execute(_txId);
    }

    function getApprovalCount(uint256 _txId)
        public
        view
        returns (uint256 count)
    {
        for (uint256 index = 0; index < owners.length; index++) {
            if (approved[_txId][owners[index]]) {
                count += 1;
            }
        }
    }

    function revoke(uint256 _txId)
        external
        onlyOwner
        txExists(_txId)
        notExecuted(_txId)
    {
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
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
    // // function withdraw() external {
    // //     require(msg.sender == owner, "Not Owner");
    // //     emit Withdraw(address(this).balance);
    //     selfdestruct(payable(msg.sender));
    // }

    // function getBalance() external view returns(uint256){
    //     return address(this).balance;
    // }
}
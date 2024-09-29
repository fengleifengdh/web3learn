// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract Salary {
   uint public data;
   function getData() external view returns(uint){
    return data;
   }
   function setData(uint _data) external{
    data = _data;
   }
}


contract Employee {
    Salary salary;
    constructor()  {
        salary = new Salary();
    }
   function getSalary() external view returns (uint){
    return salary.getData();
   }
      function setSalary(uint _data) external{
     salary.setData(_data);
   }

}
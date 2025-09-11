// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BeggingContract {
    address public owner;
    mapping(address => uint256) private donations;

    // 事件：记录捐赠信息
    event Donated(address indexed donor, uint256 amount);

    //事件： 记录取款信息
    event Withdrawn(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }
    
    // 修饰符，限制只有所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function donate() public payable {
        require(msg.value > 0,"Donation amount must be greater than 0");
        donations[msg.sender] += msg.value; //记录捐赠金额
        emit Donated(msg.sender,msg.value);// 触发捐赠记录事件
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0,"No funds to withdraw");
        // 提取合约中的所有余额到合约所有者地址
        payable(owner).transfer(balance);
        //触发提款记录事件
        emit Withdrawn(owner,balance);
    }

    // 查询某个地址的捐赠金额
    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }

    // 接收以太币的回退函数
    receive() external payable { 
        // 当直接向合约地址转账时，也记录为捐赠
        donations[msg.sender] += msg.value;
        emit Donated(msg.sender, msg.value);
    }

}
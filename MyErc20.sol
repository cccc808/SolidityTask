// 作业 1：ERC20 代币
// 任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
// 合约包含以下标准 ERC20 功能：
// balanceOf：查询账户余额。
// transfer：转账。
// approve 和 transferFrom：授权和代扣转账。
// 使用 event 记录转账和授权操作。
// 提供 mint 函数，允许合约所有者增发代币。
// 提示：
// 使用 mapping 存储账户余额和授权信息。
// 使用 event 定义 Transfer 和 Approval 事件。
// 部署到sepolia 测试网，导入到自己的钱包

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyERC20 {
    // 代币名称
    string public name;
    // 代币符号
    string public symbol;
    // 小数位数
    uint8 public decimals = 18;
    // 总供应量
    uint256 public totalSupply;
    
    // 存储账户余额
    mapping(address => uint256) public balanceOf;
    // 存储授权信息: allowance[owner][spender] = amount
    mapping(address => mapping(address => uint256)) public allowance;
    
    // 合约所有者
    address public owner;
    
    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    // 构造函数，初始化代币名称、符号和初始供应量
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
        // 初始供应量分配给合约部署者
        _mint(msg.sender, _initialSupply);
    }
    
    // 修饰符，限制只有所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 转账函数
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Invalid recipient address");
        
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    
    // 授权函数
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Invalid spender address");
        
        allowance[msg.sender][spender] = amount;
        
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    // 代扣转账函数
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(balanceOf[sender] >= amount, "Insufficient balance");
        require(allowance[sender][msg.sender] >= amount, "Allowance exceeded");
        require(recipient != address(0), "Invalid recipient address");
        
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        allowance[sender][msg.sender] -= amount;
        
        emit Transfer(sender, recipient, amount);
        return true;
    }
    
    // 增发代币函数，只有所有者可以调用
    function mint(address to, uint256 amount) public onlyOwner returns (bool) {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        
        _mint(to, amount);
        return true;
    }
    
    // 内部增发函数
    function _mint(address to, uint256 amount) internal {
        uint256 totalamount = amount * 10 ** decimals;
        totalSupply += totalamount;
        balanceOf[to] += totalamount;
        emit Transfer(address(0), to, totalamount) ;
    }
}

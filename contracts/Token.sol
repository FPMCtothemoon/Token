// Farly Priced Meme Coin - FPMC
// Our Website:    https://
// Our Socials:
// 1. Telegram
// Announcements   https://t.me/FPMCAnnouncements 
// Community Chat  https://t.me/FPMCtothemoon
// 2. Twitter      https://twitter.com/FPMCtothemoon
// 3. Discord      https://discord.gg/NhA5zDfD

// A bright future lies ahead!

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FairlyPricedMemeCoin {
    string public name = "Fairly Priced Meme Coin";
    string public symbol = "FPMC";
    uint256 public totalSupply = 3141592653589;
    uint8 public decimals = 18;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Paused(address account);
    event Unpaused(address account);
    event EmergencyStopped(address account);
    event ResumedFromEmergencyStop(address account);

    
    bool public paused = false;
    address public owner;

    modifier NotPaused() {
    require(!paused, "Contract is paused");
    _;
    }

    modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can perform this action");
    _;
    }

    constructor() {
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) public NotPaused returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public NotPaused returns (bool success) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Insufficient allowance");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
}

    function approve(address spender, uint256 value) public NotPaused returns (bool success) {
    allowance[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
}

    allowance[owner][spender] = amount;
    emit Approval(owner, spender, amount);
    }

    function increaseAllowance(address spender, uint256 addedValue) public NotPaused returns (bool) {
        require(spender != address(0), "Invalid address");
        require(addedValue > 0, "Invalid amount");

        _approve(msg.sender, spender, allowance[msg.sender][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public NotPaused returns (bool) {
        require(spender != address(0), "Invalid address");
        require(subtractedValue > 0, "Invalid amount");
        require(subtractedValue <= allowance[msg.sender][spender], "Decreased allowance below zero");

        _approve(msg.sender, spender, allowance[msg.sender][spender] - subtractedValue);
        return true;   
}

    function approve(address spender, uint256 value) public NotPaused returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
}

    function burn(uint256 value) public NotPaused returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        emit Burn(msg.sender, value);
        emit Transfer(msg.sender, address(0), value);
        return true;
    }


    function unpause() public onlyOwner {
    paused = false;
    emit Unpaused(msg.sender);
    }

    function emergencyStop() public onlyOwner {
    paused = true;
    emit EmergencyStopped(msg.sender);
    // perform emergency stop actions here
    }

    function resumeFromEmergencyStop() public onlyOwner {
    paused = false;
    emit ResumedFromEmergencyStop(msg.sender);
    // perform resume from emergency stop actions here
    }
}

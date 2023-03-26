// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract Bank {
    mapping(address => uint) private balances;
    mapping(address => uint) private tokenBalances;
    mapping(address => uint) private allowances;
    address private owner;
    uint private fee = 1;

    modifier onlyOwner() {
        require(msg.sender == owner, "This can only be done by the owner");
        _;
    }

    constructor() {
        owner = msg.sender; // also the address for the fee
    }

    function setFee(uint _fee) external {
        fee = _fee;
    }

    function _transferFee(uint _fee) internal {
        payable(owner).transfer(_fee);
    }

    function transferEth(address payable to, uint amountWei) external payable {
        require(balances[msg.sender] + msg.value >= amountWei, "Unsufficient amount");
        balances[msg.sender] += msg.value - amountWei;
        uint _fee = (amountWei * fee) / 100;
        to.transfer(amountWei - _fee);
        _transferFee(_fee);
    }

    function transferToken(address payable to, uint amount) external payable {
        require(allowances[msg.sender] >= amount, "forbidden to transfer");
        require(tokenBalances[msg.sender] + msg.value >= amount, "Unsufficient amount");
        tokenBalances[msg.sender] += msg.value - amount;
        to.transfer(amount);
    }

    function approve(address spender, uint amount) external onlyOwner {
        allowances[spender] = amount;
    }
}

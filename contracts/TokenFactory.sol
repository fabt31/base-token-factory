// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaseToken is ERC20, Ownable {
    uint256 public buyTax;
    uint256 public sellTax;
    address public marketingWallet;
    uint256 public maxTxAmount;
    uint256 public maxWalletAmount;
    bool public tradingEnabled;
    bool public antiBotEnabled;
    mapping(address => bool) public isExcludedFromFees;
    mapping(address => bool) public isAMMPair;

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 totalSupply_,
        uint256 buyTax_,
        uint256 sellTax_,
        address marketingWallet_,
        address owner_
    ) ERC20(name_, symbol_) Ownable(owner_) {
        require(buyTax_ <= 1000 && sellTax_ <= 1000, "Tax too high");
        buyTax = buyTax_;
        sellTax = sellTax_;
        marketingWallet = marketingWallet_;
        maxTxAmount = totalSupply_ / 100;
        maxWalletAmount = totalSupply_ * 2 / 100;
        isExcludedFromFees[owner_] = true;
        isExcludedFromFees[address(this)] = true;
        _mint(owner_, totalSupply_);
    }

    function enableTrading() external onlyOwner {
        tradingEnabled = true;
    }

    function _update(address from, address to, uint256 amount) internal override {
        if (!isExcludedFromFees[from] && !isExcludedFromFees[to]) {
            require(tradingEnabled, "Trading not active");
            require(amount <= maxTxAmount, "Exceeds maxTx");
            if (!isAMMPair[to]) require(balanceOf(to) + amount <= maxWalletAmount, "Exceeds maxWallet");

            uint256 tax = 0;
            if (isAMMPair[from]) tax = (amount * buyTax) / 10000;
            else if (isAMMPair[to]) tax = (amount * sellTax) / 10000;

            if (tax > 0) {
                super._update(from, marketingWallet, tax);
                amount -= tax;
            }
        }
        super._update(from, to, amount);
    }
}

contract TokenFactory {
    event TokenDeployed(address indexed token, address indexed owner, string name, string symbol);

    function deployToken(
        string calldata name,
        string calldata symbol,
        uint256 totalSupply,
        uint256 buyTax,
        uint256 sellTax,
        address marketingWallet
    ) external returns (address) {
        BaseToken token = new BaseToken(name, symbol, totalSupply, buyTax, sellTax, marketingWallet, msg.sender);
        emit TokenDeployed(address(token), msg.sender, name, symbol);
        return address(token);
    }
}

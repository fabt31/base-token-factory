# base-token-factory

> ERC20 token factory & launcher for Base L2

Deploy fully customizable ERC20 tokens on Base with built-in features: buy/sell taxes, anti-bot, automatic liquidity, vesting schedules, and initial DEX offering (IDO) support.

## Features

- 🏭 One-click ERC20 deployment with custom parameters
- 💸 Configurable buy/sell tax (up to 10%)
- 🤖 Anti-bot protection (max tx, max wallet, block delay)
- 🔒 Auto-liquidity lock via Unicrypt
- 📅 Team/investor vesting schedules
- 🚀 Aerodrome & Uniswap v3 pool creation
- ✅ Renounce ownership after launch

## Quick Deploy

```bash
git clone https://github.com/fabt31/base-token-factory
cd base-token-factory
npm install
forge install

# Deploy your token
forge script script/DeployToken.s.sol \
  --sig "run(string,string,uint256,uint256,uint256)" \
  "MyToken" "MTK" 1000000 500 500 \
  --rpc-url $BASE_RPC_URL --broadcast
```

## Token Parameters

```solidity
struct TokenConfig {
    string name;
    string symbol;
    uint256 totalSupply;    // e.g. 1_000_000 * 1e18
    uint256 buyTax;         // basis points (500 = 5%)
    uint256 sellTax;        // basis points
    address marketingWallet;
    uint256 maxTxPercent;   // % of supply (100 = 1%)
    uint256 maxWalletPercent;
    bool antiBot;
}
```

## Deployed Factory (Base Mainnet)

`0x...` (deploy your own instance)

## License

MIT

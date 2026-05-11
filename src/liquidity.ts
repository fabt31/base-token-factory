import { ethers } from "ethers";
const AERODROME_ROUTER = "0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43";
export async function createAerodromePool(token: string, amountToken: bigint, amountEth: bigint, wallet: ethers.Wallet) {
  const WETH = "0x4200000000000000000000000000000000000006";
  console.log(`Creating Aerodrome pool: ${token}/WETH with ${ethers.formatEther(amountEth)} ETH`);
  // Add liquidity via Aerodrome router
}
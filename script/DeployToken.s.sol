// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Script.sol";
import "../contracts/TokenFactory.sol";
contract DeployToken is Script {
    function run(string memory name, string memory symbol, uint256 supply, uint256 buyTax, uint256 sellTax) external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        TokenFactory factory = new TokenFactory();
        address token = factory.deployToken(name, symbol, supply * 1e18, buyTax, sellTax, msg.sender);
        console.log("Token deployed:", token);
        vm.stopBroadcast();
    }
}
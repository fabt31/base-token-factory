// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../contracts/TokenFactory.sol";
contract TokenFactoryTest is Test {
    TokenFactory factory;
    function setUp() public { factory = new TokenFactory(); }
    function test_deployToken() public {
        address token = factory.deployToken("Test","TST", 1_000_000e18, 300, 300, address(this));
        assertTrue(token != address(0));
    }
    function test_taxCannotExceed1000Bps() public {
        vm.expectRevert("Tax too high");
        factory.deployToken("Bad","BAD", 1e18, 1001, 0, address(this));
    }
}
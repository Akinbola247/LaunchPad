// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/launchPad.sol";
import "../src/KZNT.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract LaunchPadTest is Test {
    KZNToken public kznttoken;
    LaunchPad public launchpad;

    function setUp() public {
        vm.startPrank(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb);
        vm.deal(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb, 5 ether);
        kznttoken = new KZNToken("KZTtoken", "KZT");
        launchpad = new LaunchPad(IERC20(kznttoken));
        vm.stopPrank();
    }

    function testOpenDeposit() public {
       vm.startPrank(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb);
        vm.deal(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb, 5 ether);
        kznttoken.mintsupply(address(launchpad), 50);
        launchpad.OpenDeposit();
        vm.stopPrank();
    }

    function testDepositEth() public {
        testOpenDeposit();
        vm.startPrank(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC));
        vm.deal(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC), 5 ether);
        launchpad.DepositEth{value: 1 ether }();
        kznttoken.balanceOf(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC));
        vm.stopPrank();
    }
}

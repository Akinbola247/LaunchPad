// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
// import "../src/launchPad.sol";
import "../src/KZNT.sol";
import "../src/LaunchpadFactory.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IlaunchPad} from "src/IlaunchPad.sol";


contract LaunchPadTest is Test {
    KZNToken public kznttoken;
    // LaunchPad public launchpad;
    LauchpadFactory public factory;
    LaunchPad childContract;

    function setUp() public {
        vm.startPrank(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb);
        vm.deal(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb, 5 ether);
        kznttoken = new KZNToken("KZTtoken", "KZT");
        // launchpad = new LaunchPad(IERC20(kznttoken));
        factory = new LauchpadFactory();
        childContract = factory.DeployLaunchPad(address(kznttoken),address(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb));

    }

    function testOpenDeposit() public {
        kznttoken.mintsupply(address(childContract), 50);
        // launchpad.OpenDeposit();
        IlaunchPad(address(childContract)).OpenDeposit();
        
    }

    function testDepositEth() public {
        testOpenDeposit();
            // vm.warp(5 weeks);
        // IlaunchPad(address(childContract)).ManualEndDeposit();
        // IlaunchPad(address(childContract)).ExtendDeposit();
        vm.stopPrank();
        vm.startPrank(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC));
        vm.deal(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC), 5 ether);
        IlaunchPad(address(childContract)).DepositEth{value: 1 ether }();
        kznttoken.balanceOf(address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC));
        vm.stopPrank();
    }
    function testWithdrawEth() public {
        testDepositEth();
        vm.startPrank(address(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb));
        vm.deal(address(0xBB9F947cB5b21292DE59EFB0b1e158e90859dddb), 5 ether);
        IlaunchPad(address(childContract)).withdrawEth();
        vm.stopPrank();
    }
}

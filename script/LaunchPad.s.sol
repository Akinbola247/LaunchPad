// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/LaunchpadFactory.sol";
import "../src/KZNT.sol";

contract LaunchPadScript is Script {
    LauchpadFactory public factory;
    // KZNToken public kznttoken;
    LaunchPad public launchpad;
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //  kznttoken = new KZNToken("KZTtoken", "KZT");
        factory = new LauchpadFactory();
        launchpad = new LaunchPad(address(0x7C1184EeBfd073Fc592aCABFB8639B40090dD684), address(0x9B69F998b2a2b20FF54a575Bd5fB90A5D71656C1));
        vm.stopBroadcast();
    }
}

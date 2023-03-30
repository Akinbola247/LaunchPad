// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {LaunchPad} from "src/launchpad.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract lauchpadFactory {
    address overallAdmin;
    LaunchPad[] deployedContracts;
    IERC20 token;
    event check(LaunchPad _contractAddress);

    constructor(IERC20 _token){
    token = _token;
}

    function DeployContract() public returns(LaunchPad){
            LaunchPad newContract = new LaunchPad(token);                        
            deployedContracts.push(newContract);
            emit check(newContract);
            return newContract;
        }

}
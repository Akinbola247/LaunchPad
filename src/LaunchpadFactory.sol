// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "src/launchpad.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract LauchpadFactory {
    address overallAdmin;
    LaunchPad[] deployedContracts;
    IERC20 token;
    event check(LaunchPad _contractAddress);

    constructor(IERC20 _token){
    token = _token;
}

    function DeployContract(address _admin) public returns(LaunchPad){
            LaunchPad newContract = new LaunchPad(token, _admin);                        
            deployedContracts.push(newContract);
            emit check(newContract);
            return newContract;
        }

}
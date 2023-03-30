// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "src/launchpad.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract LauchpadFactory {
    address overallAdmin;
    LaunchPad[] deployedContracts;
    event check(LaunchPad _contractAddress);
    constructor(){}
    mapping(address => LaunchPad) LaunchPadDetails;
    function DeployLaunchPad(address _token, address _admin) public returns(LaunchPad){
            LaunchPad newContract = new LaunchPad(_token, _admin);                        
            deployedContracts.push(newContract);
            emit check(newContract);
            LaunchPadDetails[_admin] = newContract;
            return newContract;
        }
    function getLaunchPad(address _admin) public view returns(LaunchPad contractDetails) {
      contractDetails = LaunchPadDetails[_admin];
    }

}
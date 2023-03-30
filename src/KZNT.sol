// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract KZNToken is ERC20{
    address owner;
constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol){
        owner = msg.sender;
    }

function mintsupply(address _launchPadAddr, uint256 amount) public {
    require(msg.sender == owner, "not authorized");
    _mint( _launchPadAddr, amount * (10**decimals()));
}

}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//users should be able to deposit token eth
// make sure they get 50% of the native token
//specify start time and end time

import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract LaunchPad {
address admin;
mapping (address => uint) EthAmountDeposited;
IERC20 KZNTtoken;
struct DepositTime{
    uint startTime;
    uint endTime;
    bool depositStatus;
}
DepositTime depositTime;

constructor(IERC20 _KZNTtoken){
    KZNTtoken = _KZNTtoken;
    admin = msg.sender;
}
function OpenDeposit() public {
    require(msg.sender == admin, "not Authorized");
    uint start = block.timestamp;
    depositTime.startTime = start;
    depositTime.endTime = start + 2 weeks;
    depositTime.depositStatus = true;
}
function DepositEth() public payable {
    uint balance = (msg.sender).balance;
    require(depositTime.depositStatus == true, "not started");
    require(depositTime.startTime <= block.timestamp, "not commenced");
    require(block.timestamp <= depositTime.endTime, "deposit ended");
    require(balance != 0, "low eth balance");
    require(msg.value != 0, "input an amount");
    (bool sent, ) = payable(address(this)).call{value: msg.value}("");
    require(sent, "sendng failed");
    KZNTtoken.transferFrom(address(this), msg.sender, (msg.value/2));
    EthAmountDeposited[msg.sender] = msg.value;
}

function withdrawEth() public {
    require(msg.sender == admin, "not authorized");
    uint balance = address(this).balance;
    (bool sent, ) = payable(admin).call{value: balance}("");
    require(sent, "ether not sent");
}

receive() external payable{}
fallback() external payable{}
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
contract LaunchPad {
address admin;
mapping (address => uint) EthAmountDeposited;
address KZNTtoken;
struct DepositTime{
    uint startTime;
    uint endTime;
    bool depositStatus;
}
DepositTime depositTime;

constructor(address _KZNTtoken, address _admin){
    KZNTtoken = _KZNTtoken;
    admin = _admin;
}
function OpenDeposit() public {
    require(msg.sender == admin, "not Authorized");
    uint start = block.timestamp;
    depositTime.startTime = start;
    depositTime.endTime = start + 2 weeks;
    depositTime.depositStatus = true;
}
function ExtendDeposit() public {
    require(msg.sender == admin, "not Authorized");
    require(depositTime.endTime < block.timestamp, "deposit in progress");
    depositTime.endTime = block.timestamp + 1 weeks;
    depositTime.depositStatus = true;
}
function ManualEndDeposit() public {
    require(msg.sender == admin, "not Authorized");
    require(depositTime.endTime > block.timestamp, "deposit already ended");
    depositTime.endTime = block.timestamp;
    depositTime.depositStatus = false;
}
function DepositEth() public payable {
    require(depositTime.depositStatus == true, "not started");
    require(depositTime.startTime <= block.timestamp, "not commenced");
    require(block.timestamp < depositTime.endTime, "deposit ended");
    require(msg.value != 0, "input an amount");
    EthAmountDeposited[msg.sender] = msg.value;
    uint tokenToreceive = calculateToken(msg.value);
    IERC20(KZNTtoken).transfer(msg.sender, tokenToreceive);
}

function withdrawEth() public {
    require(msg.sender == admin, "not authorized");
    uint balance = address(this).balance;
    (bool sent, ) = payable(admin).call{value: balance}("");
    require(sent, "ether not sent");
}

function calculateToken(uint _amount) internal pure returns(uint calculated){
    calculated = (_amount * 40/100);
}
receive() external payable{}
fallback() external payable{}
}
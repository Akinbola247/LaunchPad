// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IlaunchPad {
    function OpenDeposit() external;
    function DepositEth() payable external ;
    function withdrawEth() external;
    function ManualEndDeposit() external;
    function ExtendDeposit() external;
}
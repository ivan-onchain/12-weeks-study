// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Called {
    uint256 public number;

    function increment() public {
        number++;
    }
}

contract Caller {
    // there is a new storage variable here
    address public calledAddress =0x5FC8d32690cc91D4c39d9d3abcBD16989F875707;

    uint256 public myNumber;

   function callIncrement() public {
        calledAddress.delegatecall(abi.encodeWithSignature("increment()"));
    }
}


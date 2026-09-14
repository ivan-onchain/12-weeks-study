// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

contract NoDelegateCall {
    // your code here
    // hint: https://www.rareskills.io/post/nodelegatecall

    function meaningOfLifeAndEverything() public view returns (uint256 fourtyTwo) {
        // your code here
        // this function should be callable, but not delegatecallable
        // it should return 42
        fourtyTwo = 42;
    }
}
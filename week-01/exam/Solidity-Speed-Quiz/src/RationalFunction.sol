// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract RationalFunction {
    function f(uint256 x) public pure returns (uint256) {
        // return the function f(x) = 1 / (1 - 1/x) with two decimals rounded down
        // f(0) = revert
        // f(1) = revert
        // f(2) = 200
        // f(3) = 150
        // f(4) = 133
        // f(5) = 125
        return ((x * 100) / (x - 1));
    }
}

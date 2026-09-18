// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract MultiplyConstant {
    uint256 constant five = 5;

    function multiply(uint16 x) public pure returns (uint256 fiveTimesX) {
        // TODO: Implement the logic to calculate the five times of x.
        return x * five;
    }
}

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract DivUp {
    function divUp(uint256 x, uint256 y) public pure returns (uint256) {
        // return x / y rounded up.
        // if y divides x exactly, return x / y
        // if there is a fractional part in the quotient, add 1 to the answer
        // if y == 0 revert
        uint256 div = x / y;
        if (y * div < x) return div + 1;
        return div;
    }
}

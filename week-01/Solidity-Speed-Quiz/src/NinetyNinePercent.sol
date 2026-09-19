// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract NinetyNinePercent {
    function is99Percent(uint256 x, uint256 y) public pure returns (bool) {
        // assume y < (2^256 - 1) / 10_000
        // example: x = 990, y = 1000, return true
        // example: x = 989, y = 1000, return false
        // example: x = 4499, y = 4545 return false
        // example: x = 32999999999, y = 33333333333 return false

        // return true if x >= y * 0.99. But remember, Soliidty does not have floats.

        // "x is at least 99% of y" is the same question as "100x is at least 99y",
        // which needs no fractions at all. The y bound in the comment above is what
        // guarantees y * 99 cannot overflow.
        return x * 100 >= y * 99;
    }
}

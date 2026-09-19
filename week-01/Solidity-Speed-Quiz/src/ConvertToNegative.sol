// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ConvertToNegative {
    error TooBig();

    function convertToNegative(uint256 x) external pure returns (int256) {
        // return -x
        // if -x cannot be computed, revert with "TooBig()"
        // do not hardcode any constants

        if (x > uint256(type(int256).max) + 1) revert TooBig();

        unchecked {
            return int256(0 - x);
        }
    }
}

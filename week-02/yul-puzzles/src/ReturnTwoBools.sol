// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTwoBools {
    function main(bool a, bool b) external pure returns (bool, bool) {
        assembly {
            // your code here
            // return the tuple (a,b)
            mstore(0, calldataload(4))
            mstore(32, calldataload(36))
            return(0, 64)
        }
    }
}

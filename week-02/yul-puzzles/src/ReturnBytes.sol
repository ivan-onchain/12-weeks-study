// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnBytes {
    function main(address a, uint256 b) external pure returns (bytes memory) {
        assembly {
            // your code here
            // encode a and b `abi.encode(a,b)` and return it.
            mstore(0,32)
            mstore(32,64)
            mstore(64,a)
            mstore(96,b)
            return(0,128)
        }
    }
}

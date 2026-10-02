// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnArrayOfUint256 {
    function main(uint256 a, uint256 b, uint256 c) external pure returns (uint256[] memory) {
        assembly {
            // your code here
            // return an array of [a,b,c]
            mstore(0, 32)
            mstore(32, 3)
            mstore(64, calldataload(4))
            mstore(96, calldataload(36))
            mstore(128, calldataload(68))
            return(0,160)
        }
    }
}

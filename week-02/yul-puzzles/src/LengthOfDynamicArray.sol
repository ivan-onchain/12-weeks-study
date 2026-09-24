// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract LengthOfDynamicArray {
    function main(uint256[] memory x) external view returns (uint256) {
        assembly {
            // your code here
            // return the length of array `x`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            calldatacopy(0,36,32)
            if eq(calldataload(4),32) {return(0,32)}
            return(0,0)
        }
    }
}

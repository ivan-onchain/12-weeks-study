// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // your code here
            // return the maximum value in the array
            // revert if array is empty
          
            let data := add(36, calldataload(4))
            let size := calldataload(36)  
            if eq(size, 0) {revert(0,0)}
            for {let i := data}  lt(i , add(data, mul(size, 32))) {i := add(i,32) } {
              let currentPositionData := calldataload(i)
              if gt(currentPositionData, mload(0)){mstore(0, currentPositionData)}
            }
            return(0,32)
        }
    }
}

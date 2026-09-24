// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            let sizeX := calldataload(36)
            sstore(0,sizeX)
            for {let i := 0} lt(i,sizeX) {i:= add(i, 1)}{


              let currentXValue := calldataload(add(68,mul(i,32)))
              mstore(0,0x00) 
              let currentWHIndex := add(keccak256(0,32), i)

              sstore(currentWHIndex,currentXValue)
            } 
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}

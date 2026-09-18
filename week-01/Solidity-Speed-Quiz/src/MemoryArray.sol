// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract MemoryArray {
    uint256[] array;

    function main(uint8 a) public returns (uint256[] memory) {
        // return an array that goes from 0 to a
        // for example, if a is 3, return [0, 1, 2]
        for (uint256 i = 0; i < a; i++) {
            array.push(i);
        }
        return array;
    }
}

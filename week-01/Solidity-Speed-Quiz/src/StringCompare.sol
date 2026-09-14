// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringCompare {
    function compare(string memory a, string memory b) public returns (bool) {
        // compare two strings
        // return true if they are equal
        // return false if they are not equal
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}

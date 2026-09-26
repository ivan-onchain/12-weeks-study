// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringIndex {
    function main(string memory str, uint256 index) public returns (string memory) {
        // return the character at index in str
        // assume str only consists of ascii characters
        return string(abi.encodePacked(bytes(str)[index]));
        //  return string(abi.encode(str[index]));
    }
}

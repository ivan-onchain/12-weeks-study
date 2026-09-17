// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Signature {
    function seeEncoding() external pure returns (bytes memory) {
        return abi.encodeWithSignature("foo(uint)", (5));
    }

    function seeEncoding256() external pure returns (bytes memory) {
        return abi.encodeWithSignature("foo(uint256)", (5));
    }

    /// Params are unnamed on purpose: the body reads its own raw calldata instead.
    function transfer(address, uint256) external pure returns (bytes4 selector, bytes32[] memory words) {
        selector = bytes4(msg.data[:4]);

        uint256 wordCount = (msg.data.length - 4) / 32;
        words = new bytes32[](wordCount);
        for (uint256 i = 0; i < wordCount; i++) {
            uint256 start = 4 + i * 32;
            words[i] = bytes32(msg.data[start:start + 32]);
        }
    }

    /// Static array: fixed length, so the ABI stores the elements inline.
    function transferStaticArray(uint8[3] memory, address) external pure returns (bytes memory) {
        return msg.data;
    }

    /// Dynamic array: length unknown at compile time, so the ABI stores an offset.
    function transferDynamicArray(uint8[] memory, address) external pure returns (bytes memory) {
        return msg.data;
    }

    function encodeString(string memory) external pure returns (bytes memory) {
        return msg.data;
    }

    struct Point {
        uint256 x;
        uint256 y;
    }

    function encodeStruct(Point memory) external pure returns (bytes memory) {
        return msg.data;
    }
}

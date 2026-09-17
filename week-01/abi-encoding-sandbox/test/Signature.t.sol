// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Signature} from "../src/Signature.sol";

contract SignatureTest is Test {
    Signature public sig;

    function setUp() public {
        sig = new Signature();
    }

    function test_seeEncoding() public view {
        console.logBytes(sig.seeEncoding());
    }

    function test_seeEncoding256() public view {
        console.logBytes(sig.seeEncoding256());
    }

    function test_selectorOfFoo() public pure {
        bytes32 hash = keccak256("transfer(address,uint256)");
        bytes4 selector = bytes4(hash);

        console.logBytes32(hash);
        console.logBytes4(selector);
    }

    function test_transferCalldata() public view {
        (bytes4 selector, bytes32[] memory words) =
            sig.transfer(0x3F5047BDb647Dc39C88625E17BDBffee905A9F44, 5250000000000000000000);

        console.logBytes4(selector);
        for (uint256 i = 0; i < words.length; i++) {
            console.logBytes32(words[i]);
        }
    }

    function test_transferStaticArray() public view {
        bytes memory data = sig.transferStaticArray([13, 7, 14], 0x3F5047BDb647Dc39C88625E17BDBffee905A9F44);
        _logWords(data);
    }

    function test_transferDynamicArray() public view {
        // No literal syntax for a dynamic array: allocate, then fill.
        uint8[] memory amounts = new uint8[](3);
        amounts[0] = 13;
        amounts[1] = 7;
        amounts[2] = 14;

        bytes memory data = sig.transferDynamicArray(amounts, 0x3F5047BDb647Dc39C88625E17BDBffee905A9F44);
        _logWords(data);
    }

    /// Prints the 4-byte selector, then one line per 32-byte word.
    function _logWords(bytes memory data) internal pure {
        bytes4 selector;
        assembly {
            selector := mload(add(data, 0x20))
        }
        console.logBytes4(selector);

        for (uint256 i = 4; i + 32 <= data.length; i += 32) {
            bytes32 word;
            assembly {
                word := mload(add(add(data, 0x20), i))
            }
            console.logBytes32(word);
        }
    }

    function test_encodeString() public view {
        console.logBytes(sig.encodeString("hola"));
    }

    function test_encodeStruct() public view {
        console.logBytes(sig.encodeStruct(Signature.Point({x: 234, y: 76})));
    }
}

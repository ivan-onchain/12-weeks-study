// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StringConcat} from "../src/StringConcat.sol";

contract StringConcatTest is Test {
    StringConcat c;

    function setUp() public {
        c = new StringConcat();
    }

    function test_StringConcat1() public {
        string memory a = "Hello";
        string memory b = "World";
        string memory result = c.concat(a, b);
        assertEq(result, "HelloWorld");
    }

    function testFuzz_StringConcat2(string memory a, string memory b) public {
        string memory a = "Hello";
        string memory b = "";
        string memory result = c.concat(a, b);
        assertEq(result, "Hello");
    }

    function testFuzz_StringConcat3(string memory a, string memory b) public {
        string memory a = "";
        string memory b = "World";
        string memory result = c.concat(a, b);
        assertEq(result, "World");
    }

    function testFuzz_StringConcat4(string memory a, string memory b) public {
        string memory a = "";
        string memory b = "";
        string memory result = c.concat(a, b);
        assertEq(result, "");
    }
}

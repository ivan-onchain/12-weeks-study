// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {StringIndex} from "../src/StringIndex.sol";

contract StringIndexTest is Test {
    StringIndex stringIndex;

    function setUp() public {
        stringIndex = new StringIndex();
    }

    function test_StringIndex1() public {
        assertEq(stringIndex.main("RareSkills", 0), "R");
    }

    function test_StringIndex2() public {
        assertEq(stringIndex.main("RareSkills", 1), "a");
    }

    function test_StringIndex3() public {
        assertEq(stringIndex.main("RareSkills", 2), "r");
    }
}
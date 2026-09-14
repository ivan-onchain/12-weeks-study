// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {StringCompare} from "../src/StringCompare.sol";

contract StringCompareTest is Test {
    StringCompare c;

    function setUp() public {
        c = new StringCompare();
    }

    function test_StringCompare1() public {
        bool result = c.compare("RareSkills", "RareSkills");
        assertEq(result, true);
    }

    function test_StringCompare2() public {
        bool result = c.compare("Rare Skills", "Rare Skills");
        assertEq(result, true);
    }

    function test_StringCompare3() public {
        bool result = c.compare("rareSkills", "RareSkills");
        assertEq(result, false);
    }

    function test_StringCompare4() public {
        bool result = c.compare("Rare Skills", "Rare skills");
        assertEq(result, false);
    }
}       
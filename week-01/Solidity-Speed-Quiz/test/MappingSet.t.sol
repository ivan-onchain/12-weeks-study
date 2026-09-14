// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {MappingSet} from "../src/MappingSet.sol";

contract MappingSetTest is Test {
    MappingSet c;
    function setUp() public {
        c = new MappingSet();
    }
    
    function test_increment3() public {
        c.main();
        assertEq(c.m(3), 1);
    }

    function test_increment3_twice() public {
        c.main();
        c.main();
        assertEq(c.m(3), 2);
    }
}
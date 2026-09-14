// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {StorageSet} from "../src/StorageSet.sol";

contract StorageSetTest is Test {
    StorageSet c;

    function setUp() public {
        c = new StorageSet();
    }

    function test_increment() public {
        c.main();
        (uint256 x) = c.s();
        assertEq(x, 1);
    }

    function test_increment_twice() public {
        c.main();
        c.main();
        (uint256 x) = c.s();
        assertEq(x, 2);
    }
}   
// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {IsFirstBitSet} from "../src/IsFirstBitSet.sol";

contract IsFirstBitSetTest is Test {
    IsFirstBitSet c;

    function setUp() public {
        c = new IsFirstBitSet();
    }

    function test_IsFirstBitSet() public {
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)), true);
        assertEq(c.main(bytes32(0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe)), false);
        assertEq(c.main(bytes32(0x0000000000000000000000000000000000000000000000000000000000000000)), false);
        assertEq(c.main(bytes32(0x0000000000000000000000000000000000000000000000000000000000000001)), true);
    }
}

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {IsNBitSet} from "../src/IsNBitSet.sol";

contract IsNBitSetTest is Test {
    IsNBitSet c;

    function setUp() public {
        c = new IsNBitSet();
    }

    function test_IsNBitSet() public {
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), 0), true);
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), 1), true);
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), 2), true);
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), 3), true);
    }

    function test_IsNBitSet_false() public {
        assertEq(c.main(bytes32(0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe), 0), false);
        assertEq(c.main(bytes32(0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd), 1), false);
        assertEq(c.main(bytes32(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00), 2), false);
    }
}   
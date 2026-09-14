// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {LowLevelArgs1} from "../src/LowLevelArgs1.sol";

contract Storage {
    uint256 public x;

    function rare(uint256 _x) public {
        x = _x;
    }
}

contract Storage2 {}

contract LowLevelArgs1Test is Test {
    LowLevelArgs1 c;
    Storage s;
    Storage2 s2;

    function setUp() public {
        c = new LowLevelArgs1();
        s = new Storage();
        s2 = new Storage2();
    }

    function test_LowLevelArgs1(uint256 x) public {
        c.main(address(s), x);
        assertEq(s.x(), x);
    }

    function test_LowLevelArgs1_revert() public {
        vm.expectRevert();
        c.main(address(s2), 1);
    }
}   
// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {LowLevelArgs2} from "../src/LowLevelArgs2.sol";

contract Storage {
    uint256 public x;
    uint256 public y;
    function rare(uint256 _x, uint256 _y) public {
        x = _x;
        y = _y;
    }
}

contract Storage2 {}

contract LowLevelArgs2Test is Test {
    LowLevelArgs2 c;
    Storage s;
    Storage2 s2;

    function setUp() public {
        c = new LowLevelArgs2();
        s = new Storage();
        s2 = new Storage2();
    }

    function test_LowLevelArgs2(uint256 x, uint256 y) public {
        c.main(address(s), x, y);
        assertEq(s.x(), x);
        assertEq(s.y(), y);
    }

    function test_LowLevelArgs2_revert() public {
        vm.expectRevert();
        c.main(address(s2), 1, 2);
    }
}   
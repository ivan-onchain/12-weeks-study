// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {DivUp} from "../src/DivUp.sol";

contract DivUpTest is Test {
    DivUp divUp;

    function setUp() public {
        divUp = new DivUp();
    }

    function test_divUp_case1() public {
        assertEq(divUp.divUp(12, 4), 3);
    }

    function test_divUp_case2() public {
        assertEq(divUp.divUp(12, 5), 3);
    }

    function test_divUp_case3(uint256 x) public {
        vm.assume(x > 0);
        assertEq(divUp.divUp(0, x), 0);
    }

    function test_divUp_case4() public {
        assertEq(divUp.divUp(1, 9999999999999999999999999), 1);
    }

    function test_divUp_case5() public {
        assertEq(divUp.divUp(99999, 3), 33333);
    }
}
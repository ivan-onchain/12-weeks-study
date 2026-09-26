// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {RationalFunction} from "../src/RationalFunction.sol";

contract RationalFunctionTest is Test {
    RationalFunction rationalFunction;

    function setUp() public {
        rationalFunction = new RationalFunction();
    }

    function test_rationalFunction_case0() public {
        vm.expectRevert();
        rationalFunction.f(0);
    }

    function test_rationalFunction_case1() public {
        vm.expectRevert();
        rationalFunction.f(1);
    }

    function test_rationalFunction_case2() public {
        assertEq(rationalFunction.f(2), 200);
    }

    function test_rationalFunction_case3() public {
        assertEq(rationalFunction.f(3), 150);
    }

    function test_rationalFunction_case4() public {
        assertEq(rationalFunction.f(4), 133);
    }

    function test_rationalFunction_case50() public {
        assertEq(rationalFunction.f(50), 102);
    }

    function test_rationalFunction_case600() public {
        assertEq(rationalFunction.f(600), 100);
    }

    function test_rationalFunction_case1337() public {
        assertEq(rationalFunction.f(1337), 100);
    }
}

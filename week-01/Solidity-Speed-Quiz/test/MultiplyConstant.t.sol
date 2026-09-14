// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {MultiplyConstant} from "../src/MultiplyConstant.sol";

contract MultiplyConstantTest is Test {
    MultiplyConstant multiplyConstant;

    function setUp() public {
        multiplyConstant = new MultiplyConstant();
    }

    function test_multiply_case1() public {
        uint256 fiveTimesX = multiplyConstant.multiply(0);
        assertEq(fiveTimesX, 0);
    }

    function test_multiply_case2() public {
        uint256 fiveTimesX = multiplyConstant.multiply(1);
        assertEq(fiveTimesX, 5);
    }

    function test_multiply_case3() public {
        uint256 fiveTimesX = multiplyConstant.multiply(type(uint16).max);
        assertEq(fiveTimesX, 327675);
    }
}
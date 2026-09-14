// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {Multiplication} from "../src/Multiplication.sol";

contract MultiplicationTest is Test {
    Multiplication multiplication;

    function setUp() public {
        multiplication = new Multiplication();
    }

    function test_multiply_case1() public {
        uint256 totalRewards = multiplication.multiply(0, 1);
        assertEq(totalRewards, 0);
    }

    function test_multiply_case2() public {
        uint256 totalRewards = multiplication.multiply(1, 1);
        assertEq(totalRewards, 1);
    }

    function test_multiply_case3() public {
        uint256 totalRewards = multiplication.multiply(type(uint8).max, type(uint8).max);
        assertEq(totalRewards, 65025);
    }
}

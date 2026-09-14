// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {ConvertToNegative} from "../src/ConvertToNegative.sol";

contract ConvertToNegativeTest is Test {
    ConvertToNegative convertToNegative;

    function setUp() public {
        convertToNegative = new ConvertToNegative();
    }

    function test_convertToNegative_case0() public {
        assertEq(convertToNegative.convertToNegative(1), -1);
    }

    function test_convertToNegative_case1() public {
        assertEq(convertToNegative.convertToNegative(0), 0);
    }

    function test_convertToNegative_case2() public {
        assertEq(convertToNegative.convertToNegative(57896044618658097711785492504343953926634992332820282019728792003956564819967), -57896044618658097711785492504343953926634992332820282019728792003956564819967);
    }

    function test_convertToNegative_case3() public {
        assertEq(convertToNegative.convertToNegative(57896044618658097711785492504343953926634992332820282019728792003956564819968), -57896044618658097711785492504343953926634992332820282019728792003956564819968);
    }
 
    function test_convertToNegative_case4() public {
        vm.expectRevert(abi.encodeWithSelector(ConvertToNegative.TooBig.selector));
        convertToNegative.convertToNegative(57896044618658097711785492504343953926634992332820282019728792003956564819969);
    }
}
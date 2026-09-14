// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {RemoveElement} from "../src/RemoveElement.sol";

contract RemoveElementTest is Test {
    RemoveElement removeElement;

    function setUp() public {
        removeElement = new RemoveElement();
    }

    function test_removeElement0() public {
        uint256[] memory arr = new uint256[](4);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;

        removeElement.setArr(arr);
        removeElement.removeElement(0);
        assertEq(removeElement.arr(0), 4);
        assertEq(removeElement.arr(1), 2);
        assertEq(removeElement.arr(2), 3);

        vm.expectRevert();
        removeElement.arr(3);
    }

    function test_removeElement1() public {
        uint256[] memory arr = new uint256[](4);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;

        removeElement.setArr(arr);
        removeElement.removeElement(1);
        assertEq(removeElement.arr(0), 1);
        assertEq(removeElement.arr(1), 4);
        assertEq(removeElement.arr(2), 3);

        vm.expectRevert();
        removeElement.arr(3);
    }

    function test_removeElement2() public {
        uint256[] memory arr = new uint256[](4);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;

        removeElement.setArr(arr);
        removeElement.removeElement(2);
        assertEq(removeElement.arr(0), 1);
        assertEq(removeElement.arr(1), 2);
        assertEq(removeElement.arr(2), 4);

        vm.expectRevert();
        removeElement.arr(3);
    }

    function test_removeElement3() public {
        uint256[] memory arr = new uint256[](4);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;

        removeElement.setArr(arr);
        removeElement.removeElement(3);
        assertEq(removeElement.arr(0), 1);
        assertEq(removeElement.arr(1), 2);
        assertEq(removeElement.arr(2), 3);

        vm.expectRevert();
        removeElement.arr(3);
    }

    function test_removeElement4() public {
        uint256[] memory arr = new uint256[](4);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;

        removeElement.setArr(arr);
        removeElement.removeElement(3);
        assertEq(removeElement.arr(0), 1);
        assertEq(removeElement.arr(1), 2);
        assertEq(removeElement.arr(2), 3);

        vm.expectRevert();
        removeElement.arr(4);
    }

    function test_removeElement5() public {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 2;
        arr[2] = 3;
        arr[3] = 4;
        arr[4] = 5;

        removeElement.setArr(arr);
        removeElement.removeElement(2);
        assertEq(removeElement.arr(0), 1);
        assertEq(removeElement.arr(1), 2);
        assertEq(removeElement.arr(2), 5);
        assertEq(removeElement.arr(3), 4);

        vm.expectRevert();
        removeElement.arr(4);
    }
}
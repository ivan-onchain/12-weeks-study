// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {MemoryArray} from "../src/MemoryArray.sol";

contract MemoryArrayTest is Test {
    MemoryArray c;

    function setUp() public {
        c = new MemoryArray();
    }
   
    function test_MemoryArray(uint8 a) public {
         uint256[] memory arr = c.main(a);
         assertEq(arr.length, a);
         for (uint256 i = 0; i < a; i++) {
             assertEq(arr[i], i);
         }
    }
}   
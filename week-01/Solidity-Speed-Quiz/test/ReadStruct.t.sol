// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {ReadStruct, ViewContract} from "../src/ReadStruct.sol";

contract ReadStructTest is Test {
    ReadStruct c;
    ViewContract v;

    function setUp() public {
        c = new ReadStruct();
    }

    function test_ReadStruct(uint256 x, uint256 y) public {
        v = new ViewContract(x, y);
        (uint256 x_, uint256 y_) = c.main(address(v));
        assertEq(x_, y);
        assertEq(y_, x);
    }
}

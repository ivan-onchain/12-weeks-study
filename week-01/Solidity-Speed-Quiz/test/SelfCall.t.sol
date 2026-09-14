// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {SelfCall} from "../src/SelfCall.sol";

contract SelfCallTest is Test {
    SelfCall c;

    function setUp() public {
        c = new SelfCall();
    }

    function test_SelfCall() public {
        c.main();
        assertEq(c.success(), true);
    }
}
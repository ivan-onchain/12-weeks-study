// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {LowLevel} from "../src/LowLevel.sol";

contract FooFail {
    function foo() public {
        revert();
    }
}

contract FooSuccess {
    function foo() public {}
}

contract LowLevelTest is Test {
    LowLevel c;
    FooFail f1;
    FooSuccess f2;

    function setUp() public {
        c = new LowLevel();
        f1 = new FooFail();
        f2 = new FooSuccess();
    }
 
    function test_LowLevelRevert() public {
        bool result = c.main(address(f1));
        assertEq(result, false);
    }

    function test_LowLevelSuccess() public {
        bool result = c.main(address(f2));
        assertEq(result, true);
    }
}

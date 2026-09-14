// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {LowLevelReturnString} from "../src/LowLevelReturnString.sol";

contract Baz1 {
    function baz() public returns (string memory) {
        return "Hello, World!";
    }
}

contract Baz2 {
    function baz() public returns (string memory) {
        return "Goodbye, World!";
    }
}

contract Baz3 {
    function baz() public returns (string memory) {
        require(2 == 3);
    }
}

contract LowLevelReturnStringTest is Test {
    LowLevelReturnString c;

    function setUp() public {
        c = new LowLevelReturnString();
    }

    function test_LowLevelReturn1() public {
        Baz1 b = new Baz1();
        string memory result = c.main(address(b));
        assertEq(result, "Hello, World!");
    }

    function test_LowLevelReturn2() public {
        Baz2 b = new Baz2();
        string memory result = c.main(address(b));
        assertEq(result, "Goodbye, World!");
    }
    
    function test_LowLevelReturn3() public {
        Baz3 b = new Baz3();
        string memory result = c.main(address(b));
        assertEq(result, "");
    }
}

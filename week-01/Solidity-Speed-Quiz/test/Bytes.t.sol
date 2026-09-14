// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {Bytes} from "../src/Bytes.sol";

contract BytesTest is Test {
    Bytes c;

    function setUp() public {
        c = new Bytes();
    }

    function test_Bytes(uint8 z) public {
        bytes memory result = c.main(z);
        assertEq(result.length, z);

        for (uint8 i = 0; i < z; i++) {
            assertEq(result[i], bytes1(i));
        }
    }
}

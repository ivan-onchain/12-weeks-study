// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {TryCatchReason} from "../src/TryCatchReason.sol";

contract Rare1 {
    function rare(uint256) external {

    }
}

contract Rare2 {
    function rare(uint256) external {
        revert("rare");
    }
}

contract TryCatchReasonTest is Test {
    TryCatchReason c;

    function setUp() public {
        c = new TryCatchReason();
    }

    function test_TryCatchReason(uint256 x) public {
        Rare1 r1 = new Rare1();
        bytes memory result = c.main(address(r1), x);
        assertEq(result.length, 0);
    }

    function test_TryCatchReason_Revert() public {
        Rare2 r2 = new Rare2();
        bytes memory result = c.main(address(r2), 1);

        bytes memory expected = abi.encodeWithSelector(0x08c379a0, "rare");
        assertEq(result, expected);
    }
}
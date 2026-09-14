// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {NoDelegateCall} from "../src/NoDelegateCall.sol";

contract NoDelegateCallTest is Test {
    NoDelegateCall noDelegateCall;

    function setUp() public {
        noDelegateCall = new NoDelegateCall();
    }

    function test_meaningOfLifeAndEverything() public {
        assertEq(noDelegateCall.meaningOfLifeAndEverything(), 42);
    }

    function test_delegatecall_meaningOfLifeAndEverything() public {
        (bool ok, bytes memory ret) = address(noDelegateCall).delegatecall(abi.encodeWithSelector(NoDelegateCall.meaningOfLifeAndEverything.selector));
        assertEq(ok, false);
    }
}
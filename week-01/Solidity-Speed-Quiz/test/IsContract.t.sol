// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {IsContract} from "../src/IsContract.sol";

contract Foo {}

contract IsContractTest is Test {
    IsContract isContract;

    function setUp() public {
        isContract = new IsContract();
    }

    function test_isContract_case1() public {
        Foo foo = new Foo();
        assertEq(isContract.isContract(address(foo)), true);
    }

    function test_isContract_case2() public {
        assertEq(isContract.isContract(address(1337)), false);
    }
}
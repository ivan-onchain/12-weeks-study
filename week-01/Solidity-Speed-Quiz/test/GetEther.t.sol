// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {GetEther, HasEther} from "../src/GetEther.sol";

contract GetEtherTest is Test {
    GetEther getEther;
    HasEther hasEther;

    function setUp() public {
    }

    function test_getEther() public {
        vm.deal(address(this), 1 ether);
        hasEther = new HasEther{value: 1 ether}();
        getEther = new GetEther();

        getEther.getEther(hasEther);
        assertEq(address(getEther).balance, 1 ether);
    }
}
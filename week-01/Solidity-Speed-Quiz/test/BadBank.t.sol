// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {BadBank, RobTheBank} from "../src/BadBank.sol";

contract BadBankTest is Test {
    BadBank bank;
    RobTheBank robberContract;

    address victimWallet = makeAddr("victimWallet");
    address robberWallet = makeAddr("robberWallet");

    function setUp() public {
        bank = new BadBank();
        robberContract = new RobTheBank(address(bank));

        vm.deal(victimWallet, 10 ether);
        vm.deal(robberWallet, 1 ether);

        vm.prank(victimWallet);
        bank.deposit{value: 10 ether}();
    }

    function test_RobTheBank() public {
        vm.prank(robberWallet);
        robberContract.rob{value: 1 ether}();

        assertEq(address(bank).balance, 0);
        assertEq(address(robberContract).balance, 11 ether);
    }
}
// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {AccountMaker, Account2} from "../src/AccountMaker.sol";

contract AccountMakerTest is Test {
    AccountMaker accountMaker;

    function setUp() public {
        accountMaker = new AccountMaker();
    }

    function predictAddress(address owner) public view returns (address) {
        bytes32 ownerB32 = bytes32(bytes20(uint160(owner)));
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(accountMaker),
            ownerB32,
            keccak256(abi.encodePacked(
                type(Account2).creationCode,
                abi.encode(owner)
            ))
        )))));

        return predictedAddress;
    }
    function test_accountMaker_case0() public {
        vm.deal(address(accountMaker), 100 ether);
        address owner = makeAddr("owner");
        address account = accountMaker.makeAccount{value: 100 ether}(owner);
        assertEq(account, predictAddress(owner));
        assertEq(account.balance, 100 ether);
    }

    function test_accountMaker_case1() public {
        vm.deal(address(accountMaker), 100 ether);
        address owner = makeAddr("bob");
        address account = accountMaker.makeAccount{value: 100 ether}(owner);
        assertEq(account, predictAddress(owner));
        assertEq(account.balance, 100 ether);
    }
}
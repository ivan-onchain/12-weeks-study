// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {YourContract, Forwarder, Target} from "../src/Forwarder.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {console} from "forge-std/console.sol";

contract RareToken is ERC20 {
    constructor() ERC20("Test", "TEST") {
        _mint(msg.sender, 100);
    }
}

contract ForwarderTest is Test {
    Forwarder forwarder;
    YourContract yourContract;
    Target target;
    ERC20 token;
    function setUp() public {
        yourContract = new YourContract();
        token = new RareToken();
        forwarder = new Forwarder();
        target = new Target(address(token), address(forwarder));
        console.log("target: ", address(target));

        token.transfer(address(target), 100);
    }

    function test_Forwarder() public {
        yourContract.main(address(target), address(forwarder));
        assertEq(token.balanceOf(address(yourContract)), 100);
    }
}
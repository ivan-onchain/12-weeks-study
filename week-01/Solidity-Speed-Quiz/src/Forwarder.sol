// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract YourContract {
    function main(address target, address forwarder) public {
        // make the right function call such that YourContract gets 100 tokens
        // you may only modify this function
    }
}

contract Forwarder {
    using Address for address;

    function forward(address target, bytes calldata data) public {
        target.functionCall(data);
    }
}

contract Target {
    IERC20 token;
    address forwarder;

    constructor(address _token, address _forwarder) {
        token = IERC20(_token);
        forwarder = _forwarder;
    }

    function giveTokens(address to) public {
        require(token.balanceOf(address(this)) >= 100, "Not enough tokens");
        require(msg.sender == forwarder, "Not authorized");
        token.transfer(to, 100);
    }
}
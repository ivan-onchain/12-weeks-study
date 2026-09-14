// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract SelfCall {

    bool public success;
    function main() public {
        // call me() on this contract
        // think outside the box! You can only write code here, no creating external contracts
        // or modifying other parts of this contract
    }

    function me() external {
        require(msg.sender == address(this), "not self");
        success = true;
    }
}
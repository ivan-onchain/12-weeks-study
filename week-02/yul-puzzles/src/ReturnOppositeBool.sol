// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnOppositeBool {
    function main(bool _bool) external pure returns (bool) {
        assembly {
            // your code here
            // return the opposite of `_bool`
            calldatacopy(0,4,32)
            let opposite := xor(mload(0),1)
            mstore(0,opposite)
            return (0,32)
        }
    }
}

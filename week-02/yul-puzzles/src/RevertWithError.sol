// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity
            mstore(0, 0x08c379a000000000000000000000000000000000000000000000000000000000)
            mstore(4, 32)
            mstore(36, 12)
            mstore(68, 0x5265766572745265766572740000000000000000000000000000000000000000)
            revert(0, 100)
        }
        

    }
}

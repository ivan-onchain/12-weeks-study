// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false
            // 1. check if the number is a multiple of 2 or 3
            // 2. loop from 5 to x / 2 to see if it is divisible
            // 3. increment the loop by 2 to skip the even numbers
            // 0 and 1 are not prime
            if lt(x, 2) {
                mstore(0, 0)
                return(0, 0x20)
            }

            // 2 and 3 are prime, and would fail the divisibility checks below
            if lt(x, 4) {
                mstore(0, 1)
                return(0, 0x20)
            }

            if iszero(mod(x, 2)) {
                mstore(0, 0)
                return(0, 0x20)
            }

            if iszero(mod(x, 3)) {
                mstore(0, 0)
                return(0, 0x20)
            }

            for { let i := 5 } lt(i, add(div(x, 2), 1)) { i := add(i, 2) } {
                if iszero(mod(x, i)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            mstore(0, 1)
            return(0, 0x20)
        }
    }
}

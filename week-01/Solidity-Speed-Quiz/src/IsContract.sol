// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract IsContract {

    function isContract(address addr) public view returns (bool) {
        // return true if the address has bytecode
        // sidenote: as of EIP-7702, EOAs can have bytecode

    }
}

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

library StorageSetLib {

    // implement the function increment(...)
    // it should increment the value at key 3
    // implement increment3(...)
}


contract MappingSet {

    mapping(uint256 => uint256) public m;

    using StorageSetLib for mapping(uint256 => uint256);

    function main() public {
        //m.increment3();
    }
}
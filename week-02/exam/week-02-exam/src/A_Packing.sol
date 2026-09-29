// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Base {
    uint8 public version;
    address public owner;
    bool public paused;
    uint256 public totalSupply;
}

contract A_Packing is Base {
    uint256 public constant MAX = 1000;
    address public immutable factory;

    uint128 public reserve0;
    uint64 public lastUpdate;
    uint128 public reserve1;
    uint32 public fee;
    bytes4 public selector;
    bytes32 public root;
    uint16 public a;
    uint256[3] public fixedArr;
    uint16 public b;

    constructor(address f) { factory = f; }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract B_Dynamic {
    struct Position {
        uint128 amount;
        uint64 openedAt;
        bool active;
        uint256 debt;
        address owner;
    }

    bool public initialized;
    mapping(address => uint256) public balances;
    Position public main;
    uint256[] public ids;
    mapping(address => mapping(uint256 => Position)) public positions;
    Position[] public history;
    string public name;
    uint8 public decimals;
}

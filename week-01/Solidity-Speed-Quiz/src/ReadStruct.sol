// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract ViewContract {
    struct Point {
        uint256 x;
        uint256 y;
    }

    Point public s;

    constructor(uint256 x, uint256 y) {
        s = Point({x: x, y: y});
    }
}

contract ReadStruct {
    function main(address a) public view returns (uint256 x, uint256 y) {
        // read the struct from ViewContract and return the x and y values
        // in reversed order, i.e. x is y and y is x
        // do not redeclare the struct in this contract or 
        // reference it in ViewContract
    }
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    address immutable contributor1;
    address immutable contributor2;
    address immutable contributor3;
    address immutable contributor4;
    uint256 immutable createTime;

    constructor(address[4] memory _contributors) payable {
        contributor1 = _contributors[0];
        contributor2 = _contributors[1];
        contributor3 = _contributors[2];
        contributor4 = _contributors[3];
        createTime = block.timestamp;
    }

    function distribute() external {
        unchecked {
            require(
                block.timestamp > createTime + 1 weeks,
                'cannot distribute yet'
            );
        }
        address c1 = contributor1;
        address c2 = contributor2;
        address c3 = contributor3;
        address c4 = contributor4;
        assembly {
            let amount := div(selfbalance(), 4)
            if iszero(call(2300, c1, amount, 0, 0, 0, 0)) { revert(0, 0) }
            if iszero(call(2300, c2, amount, 0, 0, 0, 0)) { revert(0, 0) }
            if iszero(call(2300, c3, amount, 0, 0, 0, 0)) { revert(0, 0) }
            if iszero(call(2300, c4, amount, 0, 0, 0, 0)) { revert(0, 0) }
        }
    }
}

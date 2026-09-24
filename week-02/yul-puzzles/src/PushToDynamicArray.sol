// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PushToDynamicArray {
    uint256[] pushToMe = [23, 4, 19, 3, 44, 88];

    function main(uint256 newValue) external {
        assembly {
            // your code here
            // push the newValue to the dynamic array `pushToMe`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
          let newLength := add(sload(pushToMe.slot),1)
          mstore(0, pushToMe.slot)  
          sstore(pushToMe.slot, newLength)
          let newIndexHash := add(keccak256(0,32),6)
          sstore(newIndexHash,newValue)
        }
    }

    function getter() external view returns (uint256[] memory) {
        return pushToMe;
    }
}

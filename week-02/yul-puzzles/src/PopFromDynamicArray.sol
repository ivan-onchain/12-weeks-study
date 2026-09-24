// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // your code here
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic
            //sstore(popFromMe.slot, newLength)
            let lastElementIndex := sub(sload(popFromMe.slot),1)
            mstore(0, popFromMe.slot)
            let lastElementIndexHash := add(keccak256(0,32), lastElementIndex)
            sstore(lastElementIndexHash, 0x00)
            let newLength := sub(sload(popFromMe.slot),1)
            sstore(popFromMe.slot, newLength)
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}

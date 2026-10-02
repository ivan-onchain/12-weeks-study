// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(uint256[] memory data) external pure returns (uint256[] memory) {
        uint256 dataLen = data.length;

        for (uint256 i = 0; i < dataLen;) {
            uint256 minIndex = i;
            uint256 minValue = data[i];

            for (uint256 j = i+1; j < dataLen;) {
                if (data[j] < minValue) {
                    minIndex = j;
                    minValue = data[j];
                }
                unchecked {
                  ++j;
                }
            }

            if (minIndex != i) {
                data[minIndex] = data[i];
                data[i] = minValue;
            }
            unchecked {
              ++i;
            }
        }
        return data;
        
    }
}

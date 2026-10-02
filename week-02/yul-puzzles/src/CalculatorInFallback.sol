// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        // your code here
        // compare the function selector in the calldata with the any of the selectors below, then
        // execute a logic based on the right function selector and store the result in `result` variable.
        // assumming operations won't overflow
         assembly {
           let selector := shr(224, calldataload(0))
                            
           switch selector
             case 0x771602f7 {
               sstore(0,add(calldataload(4), calldataload(36))) 
             }
             
             case 0xb67d77c5 {
               sstore(0,sub(calldataload(4), calldataload(36))) 
             }
             
             case  0xc8a4ac9c {
               sstore(0,mul(calldataload(4), calldataload(36))) 
             }
             
             case 0xa391c15b {
               sstore(0,div(calldataload(4), calldataload(36))) 
             }             
         }    
        // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
        // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
        // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
        // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)
    }
}

// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Bytes {
    bytes b;
    function main(uint8 z) public returns (bytes memory) {
        // if z = 0, return empty bytes
        // if z = 1, return bytes 0x00
        // if z = 2, return bytes 0x0001
        // if z = 3, return bytes 0x000102
        // if z = 4, return bytes 0x00010203
        // ...
        // etc
        
        for(uint i=0; i<z; i++){
           b = abi.encodePacked(i-1);  
        }
     return b;
   }
 
}

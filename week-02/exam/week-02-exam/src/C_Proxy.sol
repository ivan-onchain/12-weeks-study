// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Implementacion V1 detras de un proxy (el proxy no declara variables propias
// fuera de los slots ERC-1967).
contract VaultV1 {
    bool private _initialized;
    bool private _initializing;
    address public admin;
    mapping(address => uint256) public shares;
    uint256 public totalShares;
}

// V2 que se despliega como upgrade de V1.
abstract contract Pausable {
    bool public paused;
}

contract VaultV2 is Pausable {
    bool private _initialized;
    bool private _initializing;
    address public admin;
    mapping(address => uint256) public shares;
    uint256 public totalShares;
    uint256 public withdrawFee;
}

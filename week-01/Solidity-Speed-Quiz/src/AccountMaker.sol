// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;
import "@openzeppelin/contracts/utils/Create2.sol";


contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok);
    }
}

contract AccountMaker {
    function makeAccount(address owner) external payable returns (address) {
        // use create2 to create an account with the owner address
        // the salt should be the owner address
        // the value sent to them should be msg.value
 
      address addr = Create2.deploy(0, bytes32(bytes20(uint160(owner))), type(Account2).creationCode);
        return addr;
    }
}

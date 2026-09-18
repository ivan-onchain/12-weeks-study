// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Called {
    function bar() public returns (uint256) {}
}

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        // bonus challenge: use an interface and a high level call to accomplish the same task
        (bool success, bytes memory data) = a.call(abi.encodeWithSignature("bar()"));
        return uint256(bytes32(data));
        //uint x = Called(a).bar();
        //return x;
    }
}

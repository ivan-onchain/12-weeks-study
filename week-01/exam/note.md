extcodesize checks the length of the code of the EOA. Therefore, there are some cases where an EOA can be a length equal to zero but also there are some cases where a smart contract can return the length equal to zero as well. For example, when the contract isn't initialized, when the call is made from the constructor of a smart contract, the length of the code of the contract that is not initialized is zero.
Other example is when the contract is self-destroyed the length of the code is zero.

Now with the specification 7702 the things change because the length of the code of EOA is 23, and when the delegate contract of the EOA is deployed the length can be greater than zero. therefore this OP code is not realable to detect if an address is a smart contract or an EOA

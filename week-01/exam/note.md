extcodesize checks the length of the code of the EOA. Therefore, there are some cases where an EOA can be a length equal to zero but also there are some cases where a smart contract can return the length equal to zero as well. For example,  when the call is made from the constructor of a smart contract, the length of the code of the contract is zero in that point.
Other example is when the contract is self-destroyed the length of the code is zero.

Now with the specification 7702 the things change because the length of the code of EOA is 23, and when the delegate contract of the EOA is deployed the length can be greater than zero. therefore this OP code is not realable to detect if an address is a smart contract or an EOA.

For msg.sender == tx.origin When EOA with delegation executes the code it is an anti-partner because in that case the msg.sender is the contract, is the delegation contract and thetx.origin is the EOA. So if exists that restriction that only MSG.sender equal to 
 TX.origin can call a contract basically The EOAs that implement this 7702 specification will be blocked If they want to delegate the execution of that target contract to implement that requirement. 

With the specification 7702 tx.origin.code.length won't be always zero because as we know now the delegation signature mark has 23 bytes

To get msg.sender != tx.origin and msg.sender.code.length == 0 met at the same time the target contract needs to be called from the constructor of the middle contract.In other words, EOA call a middle contract and In the construction of the Contract, call the Target Contract function. 

| Contract | Variable | Type     | Size(bytes)| Slot | Offset |
| -------- | -------- | ----     | ----       | ---- | ------ |
| Base     | version  | uint8    | 1          |0     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| Base     | owner    | address  | 20         |0     | 1      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| Base     |paused    | boolean  | 1          |0     | 21     | 
| -------- | -------- | ----     | ----       | ---- | ------ |
| Base     |totalSupply| uint256 | 32         |1     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|reserve0  | uint128  | 16         |0     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|lastUpdate| uint64   | 8          |0     | 16     |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|reserve1  | uint128  | 16         |1     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|fee       | uint32   | 4          |1     | 16     |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|selector  | bytes4   | 4          |1     | 20     |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|root      | bytes32  | 32         |2     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|a         | uint16   | 2          |3     | 0      |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|fixArr    | uint256[3]| 96        |4,5,6 | 0x00   |
| -------- | -------- | ----     | ----       | ---- | ------ |
| A_Packing|b         | uint16   | 2          |7     | 0x00   |


Either Factor and MAX are store in the bytecode of the contract in a immutable way.

When I run the storageInspect of foundry I found the inital storage slot of A_Packing contract started from 2 and I set it should start from 0. I don't know if the immutable variables in some way use those 2 fist slots.....



| Contract | Variable   | Type     | Size(bytes)| Slot                        | Offset |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| initialized| bool     | 1          |0                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| balances   | mapping  | 32         |1 - keccak256(abi.encode(key, 1))| 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| main:amount| uint128  | 16         |2                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic|main:openedAt|uint64   | 8          |2                            | 16     |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic|main:active | bool     | 1          |2                            | 24     |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| main:debt  | uint256  | 32         |3                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| main:owner | address  | 20         |4                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| ids        | uint256[]| 32         |5                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| positions  |mapping(())|32 |6 - keccak256(abi.encode(key2, initHash))| 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| history    |Position[]| 32         |7                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| name       | string   | 32         |8                            | 0      |
| -------- | --------   | ----     | ----       | ----                        | ------ |
| B_Dynamic| decimals   | uint8    | 1          |9                            | 0      |
|

- Balances[user] is sload(keccak256(abi.encode(user, 1)) )
- ids[3] is sload(keccak256(abi.encode(5)) + 2
- positions[user][7].debt is sload(keccak256(abi.encode(7, keccak256(abi.encode(user,6)))))
- history[2].owner is sload(keccak256(abi.encode(7))+ 1)

- Dónde quedan los datos de name cuando mide menos de 32 bytes:
  They will live in the slot base . The string is padded to the left until 31 bytes and the length would the the rightest bytes.
, y dónde cuando mide 32 o más: The length of the string is stored in the slot base and the content of the string is stored in the hash of the slot base of the string declaration. If the string is larger that 32bytes the rest is stored in the hash of the slot base + 1. If the string lenght is greater than 64 the hash of the slot base + 2 will be filled and so on.

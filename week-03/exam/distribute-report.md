# OptimizedDistribute - optimization log

| change | gas before → after | Δ | opcode | risk | decision |
| --- | --- | --- | --- | --- | --- |
| Pristine original (storage array, mutable `createTime`, 4x `.transfer()`, checked arithmetic). | - → 72436 | - | n/a | n/a | baseline |
| `unchecked` around `createTime + 1 weeks`. | 72436 → 72370 | -66 | removes overflow check on `+` | `createTime` is `block.timestamp` at deploy time; overflow would need `createTime` within 1 week of `type(uint256).max` (~1.2 x 10^77 seconds since epoch), unreachable for any real chain | applied |
| `contributors` storage array split into 4 named `address immutable` (array itself can't be `immutable`). Send mechanism unchanged, still `.transfer()`. | 72370 → 63386 | -8984 | immutable = value baked into bytecode, not storage; removes 4 cold `SLOAD`s | none, set once in constructor | applied |
| `createTime` → `immutable`. | 63386 → 61181 | -2205 | removes 1 more cold `SLOAD` | none | applied |
| Dropped `public` from the 5 immutables. | no change | 0 | fewer auto-generated getters, smaller bytecode | none, no test calls them | applied |
| `require` moved to Yul (`revert(0,0)`). | 61181 → 61186 | +5 | no savings, Solidity's version was already minimal | breaks revert-message test | reverted |
| 4x `.transfer()` moved to Yul (`call(2300,...)`). | 61181 → 60877 | -304 | skips Solidity's `(bool,bytes)` tuple + `if(!success)` | none | applied |
| Tried reading immutables directly inside `assembly`. | doesn't compile | 0 | `Assembly access to immutable variables is not supported` | n/a | discarded, kept local copies |
| Undid the Yul `call`s, switched all 4 to `.send()` with the return value ignored. | 60877 → 61073 | +196 | `.send()` is still Solidity's higher-level call wrapper (CALLVALUE/gas-forwarding checks), costs more than the hand-rolled Yul `call` it replaced | a silently failed `.send()` leaves ETH in the contract instead of reverting - no test catches this, but it changes who ends up with the leftover | applied (as a step toward selfdestruct below) |
| Last `.send()` replaced with `selfdestruct(payable(contributor4))`. | 61073 → 57006 | -4067 | `SELFDESTRUCT` moves the whole remaining balance in one opcode, skipping `CALL`'s checks | Post EIP-6780, `SELFDESTRUCT` only wipes code/storage when the contract is created and destroyed in the same transaction - here it isn't, so the contract keeps its code and stays callable. Combined with the row above: if `contributor1-3`'s `.send()` silently fails, that undelivered amount stays in the contract balance and gets swept to `contributor4` by this `selfdestruct` instead of being caught | applied |

**Final: 57006 / target 57044.**

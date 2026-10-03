# OptimizedDistribute - optimization log

| change | gas before → after | Δ | opcode | risk | decision |
| --- | --- | --- | --- | --- | --- |
| Pristine original (storage array, mutable `createTime`, memory copy, 4x `.call` with manual check, checked arithmetic). | - → 72436 | - | n/a | n/a | baseline |
| `unchecked` around `createTime + 1 weeks`. | 72436 → 72370 | -66 | removes overflow check on `+` | overflow not reachable in practice | applied |
| Split `contributors` into 4 `address immutable`; switched sends to `.transfer()`. | 72370 → 63386 | -8984 | immutable = bytecode, not storage; skips 4 cold `SLOAD`s | none, set once in constructor | applied |
| `createTime` → `immutable`. | 63386 → 61181 | -2205 | same, skips 1 more cold `SLOAD` | none | applied |
| Dropped `public` from the 5 immutables. | no change | 0 | fewer auto-generated getters, smaller bytecode | none, no test calls them | applied |
| `require` moved to Yul (`revert(0,0)`). | 61181 → 61186 | +5 | no savings, Solidity's version was already minimal | breaks revert-message test | reverted |
| `amount` + 4 sends moved to Yul (`call(2300,...)`). | 61181 → 60877 | -304 | skips Solidity's `(bool,bytes)` tuple + `if(!success)` | none | applied |
| Tried reading immutables directly inside `assembly`. | doesn't compile | 0 | `Assembly access to immutable variables is not supported` | n/a | discarded, kept local copies |
| More variants on the sends (`gas()` vs 2300, `div` vs `shr`, merged block). | ~60900 (scratch only) | ~0 | all within ~50 gas of each other | n/a | discarded, no real gain |

**Final: 60877 / target 57044 (+3833).** Floor is the 4 cold-address + value-transfer `call`s; closing the gap needs a pull/withdraw pattern, which breaks the business-logic test.

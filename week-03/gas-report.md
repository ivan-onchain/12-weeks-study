## ArraySum

| change | gas before → after | why (opcode) | risk |
| --- | --- | --- | --- |
| Rewrote the entire loop in assembly, but gas consumption increased because each iteration still performs an `SLOAD`. | 23396 → 23410 | n/a | n/a |

## OptimizedRequire

| change | gas before → after | why (opcode) | risk |
| --- | --- | --- | --- |
| Rewrote `purchaseToken` in assembly (`sload`/`sstore` on `lastPurchaseTime.slot`, `revert(0,0)` instead of string requires), but gas consumption increased because the cold `SLOAD` and the zero→nonzero `SSTORE` on `lastPurchaseTime` already dominate the cost and assembly didn't remove either one. | 43317 → 43322 | n/a | n/a |
| Study-only, off-limits (puzzle says do not modify `lastPurchaseTime`/`COOLDOWN`): initialized `lastPurchaseTime` to 1 in the constructor instead of leaving it at the default 0. | 43317 → 26217 | zero→nonzero `SSTORE` (20000 gas) replaced by nonzero→nonzero `SSTORE` (2900 gas) on the first purchase | breaks the puzzle's stated constraint; the init write still costs gas, just moved to deployment |

## OptimizedVote

| change | gas before → after | why (opcode) | risk |
| --- | --- | --- | --- |
| Baseline, before further optimization. | 134888 → pending | n/a | n/a |
| Wrapped `++c` (in `createProposal`) and `proposals[_proposal].voteCount += 1` (in `vote`) in `unchecked` blocks. | 134888 → 134411 | removes the implicit overflow comparison + conditional revert that Solidity 0.8 inserts around checked `+`/`++` | overflow: nothing in the contract caps the number of proposals or votes, and both counters are `uint8`, so `c` and `voteCount` can actually reach 256 and wrap silently instead of reverting |

## OptimizedArraySort

| change | gas before → after | why (opcode) | risk |
| --- | --- | --- | --- |
| Baseline, before further optimization. | 26784 → pending | n/a | n/a |
| Cached `data[i]` into a local `iValue` before the inner loop, so the end-of-iteration swap reuses it instead of re-reading `data[i]` from memory. | 26784 → 26741 | removes one redundant `MLOAD` (plus its address computation) per outer-loop iteration that performs a swap | none - same comparisons and writes, just one fewer re-read of a value already on the stack |

## OptimizedSecurity101

This gas-optimization workflow does not apply to this exercise. Re-ran `test/Security101.js`: 1 passing, gas logged at 605252.

`test/Security101.js` has no gas assertion anywhere - the "Gas target (redacted)" describe block only calls `logGasUsage(gasUsed)`, it never does `expect(gasUsed).lte(...)`. The real pass/fail condition is the `afterEach`: the attacker's balance must exceed 9900 ETH, the victim contract's balance must equal exactly 0, and the attacker must only have sent one transaction (`transactionCount === 1`). This puzzle is a reentrancy exploit exercise, not a gas-minimization one - the win condition is draining the victim contract in a single transaction, regardless of how much gas that transaction costs.

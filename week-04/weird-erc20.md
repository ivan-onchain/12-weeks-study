# How weird erc20 token could break erc4626 vaults.

1. Reentrancy calls: It wouldn't breake anything because 4626 has measures that avoid a reentrancy but these erc777 token could create chained calls to affect throughout transversal integrations.
2. Missing return values: Despite erc4626 uses safeTransfer, tokens like tether gold, that make a false return when transfer is successfull, definitelly will break the transfer flow.
3. Fee on transfer: It would break the accounting of the vault, because it would log more tokens than it actually received.
4. Balance Modifications Outside of Transfers (rebasing/airdrops): Similar than above point, it would break the internal counting of the vault.
5. Upgradable Tokens: Definitely tokens that can modify his functions behavior can harm the protocol that integrate it.
6. Flash Mintable Tokens: As vault doesn't rely on the total supply of the underlying token to make calculation, it shouln't harm the vault in any way.
7. Tokens with Blocklists: It wouldn't break the internal logic or accounting of the vault. But would prevent the user to witdraw funds from the vault.
8. Pausable Tokens: Same risk of the last one.
9. Approval Race Protections: It doesn't affect directly the vault system.
10. Revert on Approval To Zero Address: It doesn't affect directly the vault system.
11. Revert on Zero Value Approval: It doesn't affect directly the vault system.
12. Revert on Zero Value Transfers:  It doesn't affect directly the vault system.
13. Multiple Token Addresses: Per-se it shouldn't affect the internal logic or accouint but definitelly it is a dangerous weird-token. 
14. Low Decimals: Token with 2 decimal could cause precision loss in the vault calculations.
15. High Decimals: If decimal are extrem high, it could cause overflows issues.
16. transferFrom with src == msg.sender: I didn't understand the vuln here.
17. Non string metadata: This metadata encoding/decoding issue shouldn't affect or break the vaul.
18. Revert on Transfer to the Zero Address: It doesn't affect directly the vault system.
19. No Revert on Failure: Erc4626 uses safeTransfer, so it could prevent this vuln
20. Revert on Large Approvals & Transfers: It definitelly would stuck funds because vaults could easily require approval for large amounts.
21. Code Injection Via Token Name: It shouldn't break any logic of the vault.
22. Transfer of less than amount: This could break the internal accounting of the vault, because will allow to not transfer that required amount, but transfer only the amount of the user.
23. ERC-20 Representation of Native Currency: It shouldn't break the vault.

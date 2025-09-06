// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

// 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数
contract Voting {
    struct Candidate {
        string name;
        bool exist;
        uint voteCount;
    }

    mapping(string => Candidate) public candidates;
    Candidate[] candidatelist; 

    //初始化候选人名单
    function initCandidate(string[] memory names) public {
        for(uint i=0;i<names.length;i++){
            Candidate memory temp = Candidate(names[i],true,0);
            candidatelist.push(temp);
            candidates[names[i]] = temp;
        }
    }

    //获取候选人名单
    function getCandidateNames() public view returns (string[] memory){
        string[] memory temp = new string[](candidatelist.length);
        for(uint i = 0;i<candidatelist.length;i++){
            temp[i]=candidatelist[i].name;
        }

        return temp;
    }

    //根据候选人名字进行投票
    function vote(string memory name,uint count) public {
        require(candidates[name].exist, "This candidate is not exist");
        candidates[name].voteCount += count;
    }

    //根据候选人名字查询票数
    function getVotes(string calldata name) public view returns (uint) {
        require(candidates[name].exist,"This candiate is not exist");
        return candidates[name].voteCount;
    }

    //重置所有候选人得票数
    function resetVotes() public {
        for(uint i=0;i<candidatelist.length;i++){
            candidatelist[i].voteCount = 0;
        }
    }


}
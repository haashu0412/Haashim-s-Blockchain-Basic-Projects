// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding{
    
    struct Request{
        string description;
        address payable recipient;
        uint value ;
        bool completed;
        uint no_Voter;
        mapping(address=>bool) voters;
    }
    
    mapping(address=>uint) public contributors;
    mapping(uint=>Request) public request;  
    uint public numReq;
    address public manager;
    uint public minimum_contribution;
    uint public deadline;
    uint public target;
    uint public raised_amount;
    uint public No_contributor;

    constructor(uint _target, uint _deadline){
        target = _target;
        deadline = block.timestamp + _deadline;
        minimum_contribution = 100 wei;
        manager = msg.sender;
    }

    modifier onlyManager(){
        require(msg.sender == manager , "You are not theManager");
        _;
    }
    function createReq(string calldata _description , address payable _recipient, uint _value) public {
        Request storage newRequest = request[numReq];
        numReq++;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.no_Voter = 0;
    }

    function contribution() public payable{
        require(block.timestamp < deadline , "Deadline has passed");
        require(msg.value >= minimum_contribution , "Minium contribution is not satisfied" );

        if(contributors[msg.sender] == 0){
            No_contributor++;
        }
        contributors[msg.sender] += msg.value;
        raised_amount += msg.value;
    }

    function getbalance() public view returns(uint) {
        return address(this).balance;
    }

    function refund() public {
        require(block.timestamp > deadline && raised_amount < target , "You are not eligible");
        require(contributors [msg.sender] > 0 , "You are not a contributor");
        payable(msg.sender).transfer(contributors[msg.sender]);
        contributors[msg.sender] = 0;
    }

    function voteRequest(uint _reqNo) public{
        require(contributors[msg.sender] > 0, "You are not a contributor");
        Request storage thisRequest = request[_reqNo];
        require(thisRequest.voters[msg.sender] == false, "You have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.no_Voter++;
    }

    function makePay(uint _reqNo) public onlyManager(){
        require(raised_amount >= target, "Target is not reached");
        Request storage thisRequest = request[_reqNo];
        require(thisRequest.completed == false , "The request has not been completed");
        require(thisRequest.no_Voter > No_contributor/2 , "Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }
    
}
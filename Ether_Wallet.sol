// SPDX-License_Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleWallet{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable{}

    function withdraw(uint _amount) public {
        require(msg.sender == owner , "Only the owner can send money");
        require(address(this).balance >= _amount, "Insufficient Balance");
        payable(owner).transfer(_amount);
    }

    function GetBalance() public view returns(uint){
        return address(this).balance;
    }
}
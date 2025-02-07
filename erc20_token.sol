// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Vanila{
    mapping(address => uint256) public balances ;
    string public name = "vanila";
    string public symbol = "VAN";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to , uint256 value );
    
    constructor(uint256 _initialSupply){
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
    }

    function transfer (address _to, uint256 _value) public returns(bool){
        require(balance[msg.sender] >= value , "Insufficient Balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender , _to , _value);
        return true;
    }
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX_Swap{
    IERC20 public token;
    uint public totalLiquidity;
    mapping(address => uint) public liquidity;

    constructor(address _token){
        token = IERC20(_token);
    }

    function addLiquidity(uint _tokenAmount) public payable{
        require(msg.value > 0 , "Must provide ETH");
        require(token.transferfrom(msg.sender , address(this), _tokenAmount), "Transfer Failed");

        liquidity[msg.sender] += msg.value;
        totalLiquidity += msg.value;
    }

    function SwapEthToToken() public payable{
        uint tokenAmount = (msg.value * token.balanceOf(address(this))) / address(this).balance;
        require(token.transfer(msg.sender, tokenAmount) , "Swap Failed");
    }

    function WithdrawLiquidity() public {
        uint ethamt = liquidity[msg.sender];
        require(ethamt > 0 , "NO Liquidity");

        uint tokenAmount = (ethamt * token.balance(address(this))) / totalLiquidity;
        liquidity[msg.sender] = 0;
        totalLiquidity -= ethamt;

        payable(msg.sender).transfer(ethamt);
        require(token.trnsfer(msg.sender, tokenAmount), "Withdraw Failed");
    }
}
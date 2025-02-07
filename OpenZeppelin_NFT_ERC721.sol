// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleNFT is ERC721Enumerable, Ownable{
    uint public tokenCounter;

    constructor() ERC721("SimpleNFT" , "SNFT"){
        tokenCounter = 0 ;
    }

    function mintNFT(address recipient) public onlyOwner{
        _safeMint(recipient, tokenCounter);
        tokenCounter++;
    }
}

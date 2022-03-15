//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Fragments is ERC1155{

    constructor() ERC1155(""){}

    function mint(uint tokenId,uint amount) external {
        _mint(msg.sender,tokenId,amount,"");
    }

}
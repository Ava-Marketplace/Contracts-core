//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract Compose is ERC721Enumerable{

    IERC1155 Fragments;

    uint tokenId;

    struct component{
        uint[] tokenIds;
        uint[] amounts;
    }

    mapping(uint=>component) composition;

    constructor(address _fragments) ERC721("Compose POC","POC"){
        Fragments = IERC1155(_fragments);
    }

    function compose(uint[] memory tokenIds,uint[] memory amounts) external {
        require(tokenIds.length == amounts.length,"Length mismatch");
        tokenId++;
        for(uint i=0;i<tokenIds.length;i++){
            Fragments.safeTransferFrom(msg.sender, address(this), tokenIds[i], amounts[i], "");
        }
        composition[tokenId] = component(tokenIds,amounts);
        _safeMint(msg.sender, tokenId);
    }

    function deCompose(uint _tokenId) external {
        require(ownerOf(_tokenId)==msg.sender,"Not owner");
        component storage currentComp = composition[_tokenId];
        for(uint i=0;i<currentComp.tokenIds.length;i++){
            Fragments.safeTransferFrom(address(this),msg.sender,currentComp.tokenIds[i], currentComp.amounts[i],"");
        }
        delete composition[_tokenId];
        _burn(_tokenId);
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721.sol";

contract NFTFactory {

    SampleNFT nft;
    SampleNFT[] nfts;

    function createNewNFT (string memory _name, string memory _symbol, address _owner) public {
        nft = new SampleNFT(_name, _symbol, _owner);
        
        nfts.push(nft);
        // return nft;
    }

    function mintNft (uint256 _tokenId, string  memory _tokenUri) public {
        nft.mint(_tokenId, _tokenUri);
    }

    function getAllNfts () external view returns (SampleNFT[] memory){
        return nfts;
    }
}

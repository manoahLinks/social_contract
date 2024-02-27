// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721.sol";

contract NFTFactory {

    SampleNFT nft;
    SampleNFT[] nfts;

    function createNewNFT (address _owner) public returns (SampleNFT) {
        nft = new SampleNFT(_owner);
        
        nfts.push(nft);
        return nft;
    }

    function getAllNfts () external view returns (SampleNFT[] memory){
        return nfts;
    }
}

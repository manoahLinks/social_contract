// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC721.sol";

interface INFTFactory {

    function createNewNFT (string memory _name, string memory _symbol, address _owner) external ;

     function mintNft (uint256 _tokenId, string  memory _tokenUri) external;

}
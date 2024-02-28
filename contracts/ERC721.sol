// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SampleNFT is ERC721URIStorage, Ownable {
    constructor(
        string memory _symbol,
        string memory _name,
        address _initialOwner
    ) ERC721(_symbol, _name) Ownable(_initialOwner) {}

    function mint(uint _tokenId, string calldata _tokenUri) external {
        _mint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenUri);
    }
}
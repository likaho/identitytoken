// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IdentityToken is ERC721, Ownable {
    struct Identity {
        string name;
        string dataCID; // IPFS CID (Content Identifier) for NFT data
    }

    Identity[] private identities;
    mapping(uint256 => address) private tokenCreators;

    constructor() ERC721("IdentityToken", "IDT") {}

    function mint(string memory _name, string memory _dataCID) external {
        uint256 tokenId = identities.length;
        identities.push(Identity(_name, _dataCID));
        _mint(msg.sender, tokenId);
        tokenCreators[tokenId] = msg.sender;
    }

    function getDataCID(uint256 _tokenId) external view returns (string memory) {
        require(_exists(_tokenId), "Token does not exist");
        return identities[_tokenId].dataCID;
    }

    function updateDataCID(uint256 _tokenId, string memory _newDataCID) external {
        require(_exists(_tokenId), "Token does not exist");
        require(ownerOf(_tokenId) == msg.sender || owner() == msg.sender, "Not token owner or contract owner");
        identities[_tokenId].dataCID = _newDataCID;
    }

    function burn(uint256 _tokenId) external {
        require(_exists(_tokenId), "Token does not exist");
        require(ownerOf(_tokenId) == msg.sender || owner() == msg.sender, "Not token owner or contract owner");
        _burn(_tokenId);
        delete identities[_tokenId];
        delete tokenCreators[_tokenId];
    }

    function isTokenCreator(uint256 _tokenId) external view returns (bool) {
        require(_exists(_tokenId), "Token does not exist");
        return tokenCreators[_tokenId] == msg.sender;
    }
}

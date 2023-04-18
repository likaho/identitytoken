// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract MyNFT is ERC721 {
    uint256 public tokenId;
    string public baseURI;
    mapping (uint256 => string) private tokenURIs;

    constructor(string memory _name, string memory _symbol, string memory _baseURI) ERC721(_name, _symbol) {
        baseURI = _baseURI;
    }

    function mintNFT(address _to, string memory _tokenURI) external returns (uint256) {
        tokenId++;
        _safeMint(_to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        return tokenId;
    }

    function _setTokenURI(uint256 _tokenId, string memory _tokenURI) internal virtual {
        require(_exists(_tokenId), "ERC721Metadata: URI set of nonexistent token");
        tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenURIs[_tokenId])) : "";
    }
}

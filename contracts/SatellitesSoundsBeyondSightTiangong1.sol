// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SatellitesSoundsBeyondSightTiangong1 is ERC721URIStorage, Pausable, Ownable {
    uint256 tokenCount = 0;
    uint256 tokenLimit = 1;
    constructor() ERC721("Satellites: Sounds Beyond Sight - Tiangong-1", "TNG1")
    {}

    function totalSupply() public view returns(uint) {
        return tokenLimit;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function burn(uint256 tokenId) public virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
        tokenCount -= 1; // this line is for testing purposes only remove from live 1/1 NFTs
    }

    function safeMint(address to, uint256 tokenId, string memory metadataURI) public onlyOwner {
        if (tokenCount < tokenLimit) {
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, metadataURI);
            tokenCount += 1;
        } 
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
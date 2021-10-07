pragma solidity ^0.8.0;

import "./openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract PhotoNFT is ERC721Enumerable {
    uint256 public currentPhotoId;

    constructor(
        address owner,
        string memory _nftName,
        string memory _nftSymbol,
        string memory _tokenURI,
        uint photoPrice
    ) 
        public 
        ERC721(_nftName, _nftSymbol) 
    {
        mint(owner, _tokenURI);
    }

    function mint(address to, string memory tokenURI) public returns (bool) {
        uint newPhotoId = getNextPhotoId();
        currentPhotoId ++;
        _mint (to, newPhotoId);
        _setTokenURI(newPhotoId, tokenURI);
    }
        function getNextPhotoId() private returns (uint nextPhotoId) {
        return currentPhotoId.add(1);
    }
}
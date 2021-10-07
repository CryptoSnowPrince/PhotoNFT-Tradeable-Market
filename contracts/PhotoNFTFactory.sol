pragma solidity ^0.8.0;

import { PhotoNFTFactoryStorages } from "./photo-nft-factory/commons/PhotoNFTFactoryStorages.sol";
import { PhotoNFT } from "./PhotoNFT.sol";
import { PhotoNFTMarketplace } from "./PhotoNFTMarketplace.sol";
import { PhotoNFTData } from "./PhotoNFTData.sol";

contract PhotoNFTFactory is PhotoNFTFactoryStorages {

    address[] public photoAddresses;
    address PHOTO_NFT_MARKETPLACE;

    PhotoNFTMarketplace public photoNFTMarketplace;
    PhotoNFTData public photoNFTData;

    constructor (PhotoNFTMarketplace _photoNFTMarketplace, PhotoNFTData _photoNFTData) public {
        photoNFTMarketplace = _photoNFTMarketplace;
        photoNFTData = _photoNFTData;
        PHOTO_NFT_MARKETPLACE = address(photoNFTMarketplace);
    }

    function createNewPhotoNFT(string memory nftName, string memory nftSymbol, uint photoPrice, string memory ipfsHashOfPhoto) public returns (bool) {
        address owner = msg.sender;
        string memory tokenURI = getTokenURI(ipfsHashOfPhoto);
        PhotoNFT photoNFT = new PhotoNFT(owner, nftName, nftSymbol, tokenURI, photoPrice);
        photoAddresses.push(address(photoNFT));

        photoNFTData.saveMetadataOfPhotoNFT(photoAddresses, photoNFT, nftName, nftSymbol, msg.sender, photoPrice, ipfsHashOfPhoto);
        photoNFTData.updateStatus(photoNFT, "Open");

         emit PhotoNFTCreated(msg.sender, photoNFT, nftName, nftSymbol, photoPrice, ipfsHashOfPhoto);
    }

    function baseTokenURI() public pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function getTokenURI(string memory _ipfsHashOfPhoto) public view returns (string memory) {
        return Strings.strConcat(baseTokenURI(), _ipfsHashOfPhoto);
    }

}


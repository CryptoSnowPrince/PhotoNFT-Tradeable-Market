pragma solidity ^0.8.0;

import { PhotoNFTDataStorages } from "./photo-nft-data/commons/PhotoNFTDataStorages.sol";
import { PhotoNFT } from "./PhotoNFT.sol";

contract PhotoNFTData is PhotoNFTDataStorage {
    address[] public photoAddresses;

    constructor() public {}

    function saveMetadataOfPhotoNFT(
        address[] memory _photoAddresses,
        PhotoNFT _photoNFT,
        string memory _photoNFTName,
        string memory _photoNFTSymbol,
        address _ownerAddress,
        uint _photoPrice,
        string memory _ipfsHashOfPhoto
    ) public returns (bool) {
        Photo memory photo = Photo({
            photoNFT: _photoNFT,
            photoNFTName: _photoNFTName,
            photoNFTSymbol: _photoNFTSymbol,
            ownerAddress: _ownerAddress,
            photoPrice: _photoPrice,
            ipfsHashOfPhoto: _ipfsHashOfPhoto,
            status: "Open",
            reputation: 0
        });
        photos.push(photo);
        photoAddresses = _photoAddresses;
    }

    function updateOnwerOfPhotoNFT(PhotoNFT _photoNFT, address _newOwner) public returns (bool) {
        uint photoIndex = getPhotoIndex(_photoNFT);

        Photo storage photo = phots[photoIndex];
        require (_newOwner != address(0));
        photo.ownerAddress = _newOwner;
    }

    function updateStatus(PhotoNFT _photoNFT, string memory _newStatus) public returns (bool) {
        uint photoIndex = getPhotoIndex(_photoNFT);

        Photo storage photo = photos[photoIndex];
        photo.status = _newStatus;
    }

    function getPhoto(uint index) public view returns (Photo memory _photo) {
        Photo memory photo = photos[index];
        return photo;
    }

    function getPhotoIndex(PhotoNFT photoNFT) public view returns (uint _photoIndex) {
        address PHOTO_NFT = address(photoNFT);

        uint photoIndex;
        for (uint i = 0; i < photoAddresses.length; i ++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                photoIndex = i;
            }
        }
        return photoIndex;
    }

    function getPhotoByNFTAddress(PhotoNFT photoNFT) public view returns (Photo memory _photo) {
        address PHOTO_NFT = address(photoNFT);

        uint photoIndex;
        for (uint i = 0; i < photoAddresses.length; i ++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                photoIndex = i;
            }
        }

        Photo memory photo = photos[photoIndex];
        return photo;
    }

    function getAllPhotos() public view returns (Photo[] memory _photos) {
        return photos;
    } 
}
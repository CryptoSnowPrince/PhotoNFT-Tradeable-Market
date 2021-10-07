pragma solidity ^0.8.0;

import { PhotoNFT } from "./PhotoNFT.sol";
import { PhotoNFTTradable } from "./PhotoNFTTradable.sol";
import { PhotoNFTMarketplaceEvents } from "./photo-nft-marketplace/commons/PhotoNFTMarketplaceEvents.sol";
import { PhotoNFTData } from "./PhotoNFTData.sol";

contract PhotoNFTMarketplace is PhotoNFTTradable, PhotoNFTMarketplaceEvents {
    address public PHOTO_NFT_MARKETPLACE;

    PhotoNFTData public photoNFTData;
    constructor(PhotoNFTData _photoNFTData) public PhotoNFTTradable (_photoNFTData) {
        photoNFTData = _photoNFTData;
        address payable PHOTO_NFT_MARKETPLACE = payable(address(this));
    }

    function buyPhotoNFT(PhotoNFT _photoNFT) public payable returns (bool) {
        PhotoNFT photoNFT = _photoNFT;

        PhotoNFTData.Photo memory photo = photoNFTData.getPhotoByNFTAddress(photoNFT);
        address _seller = photo.ownerAddress;
        address payable seller = payable(_seller);
        uint buyAmount = photo.photoPrice;

        require (msg.value == buyAmount);

        seller.transfer(buyAmount);

        address buyer = msg.sender;

        uint photoId = 1;
        photoNFT.approve(buyer, photoId);
                address ownerBeforeOwnershipTransferred = photoNFT.ownerOf(photoId);

        /// Transfer Ownership of the PhotoNFT from a seller to a buyer
        transferOwnershipOfPhotoNFT(photoNFT, photoId, buyer);    
        photoNFTData.updateOwnerOfPhotoNFT(photoNFT, buyer);
        photoNFTData.updateStatus(photoNFT, "Cancelled");

        /// Event for checking result of transferring ownership of a photoNFT
        address ownerAfterOwnershipTransferred = photoNFT.ownerOf(photoId);
        emit PhotoNFTOwnershipChanged(photoNFT, photoId, ownerBeforeOwnershipTransferred, ownerAfterOwnershipTransferred);
    }

    function reputation(address from, address to, uint256 photoId) public returns (uint256, uint256) {
        return (0, 0);
    }
    

    function getReputationCount(uint256 photoId) public view returns (uint256) {
        uint256 curretReputationCount;

        return curretReputationCount;
    }    
}
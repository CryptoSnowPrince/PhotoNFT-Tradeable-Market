pragma solidity ^0.8.0;

import { PhotoNFT } from "../../PhotoNFT.sol";

contract PhotoNFTDataObjects {
    
    struct Photo {
        PhotoNFT photoNFT;
        string photoNFTName;
        string photoNFTSymbol;
        address ownerAddress;
        uint photoPrice;
        string ipfsHashOfPhoto;
        string status;
        uint256 reputation;
    }
}
pragma solidity ^0.8.0;

import { PhotoNFTDataObjects } from "./PhotoNFTDataObjects.sol";

contract PhotoNFTDataStorage is PhotoNFTDataObjects {
    Photo[] public photos;
}

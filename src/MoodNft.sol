// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MOODNFT__YOUARENOTOWNER();
    uint256 private s_counter;

    string private s_happySvgUri;
    string private s_sadSvgUri;

    mapping(uint256 tokenId => MoodFlip) private s_idToTokenSvg;
    event CreatedNFT(uint256 indexed tokenId);

    enum MoodFlip {
        HAPPY,
        SAD
    }

    constructor(
        string memory _happyImageUri,
        string memory _sadSvgImageUri
    ) ERC721("mood", "md") {
        s_happySvgUri = _happyImageUri;
        s_sadSvgUri = _sadSvgImageUri;
        s_counter = 0;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNft() public {
        uint256 tokenCounter = s_counter;
        _safeMint(msg.sender, s_counter);
        s_counter = s_counter + 1;
        emit CreatedNFT(tokenCounter);
    }

    function flipMoodNft(uint256 tokenId) public {
        if (!_isAuthorized(ownerOf(tokenId), msg.sender, tokenId)) {
            revert MOODNFT__YOUARENOTOWNER();
        }
        if (s_idToTokenSvg[tokenId] == MoodFlip.HAPPY) {
            s_idToTokenSvg[tokenId] = MoodFlip.SAD;
        } else {
            s_idToTokenSvg[tokenId] = MoodFlip.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        // string memory tokenData = string.concat('{"name": "', name(), '"}');
        string memory imageURI = s_happySvgUri;

        if (s_idToTokenSvg[tokenId] == MoodFlip.SAD) {
            imageURI = s_sadSvgUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /** view pure */

    function getCounter() public view returns (uint256) {
        return s_counter;
    }

    function getIdToTokenSvg(
        uint256 indexOfState
    ) public view returns (MoodFlip) {
        return s_idToTokenSvg[indexOfState];
    }

    function getSadUri() public view returns (string memory) {
        return s_sadSvgUri;
    }

    function getHappyUri() public view returns (string memory) {
        return s_happySvgUri;
    }
}

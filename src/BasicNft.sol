// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_counter;

    mapping(uint256 tokenId => string tokenUri) private s_IdToUri;

    constructor() ERC721("TeddyBear", "TB") {
        s_counter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_IdToUri[s_counter] = tokenUri;
        _safeMint(msg.sender, s_counter);
        s_counter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_IdToUri[tokenId];
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployBasicNft;

    address USER = makeAddr("USER");

    string public tokenUri =
        "ipfs://bafkreicdyn4gexdoou3fmsuwwbtpnyshvp32xhqvefjm2zho4ilfnp5eua";

    function setUp() external {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testUriIsRight() public {
        vm.prank(USER);
        basicNft.mintNft(tokenUri);
        vm.prank(USER);
        string memory nftUri = basicNft.tokenURI(0);

        assert(
            keccak256(abi.encodePacked(nftUri)) ==
                keccak256(abi.encodePacked(tokenUri))
        );
    }

    
}

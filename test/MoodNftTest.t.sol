// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";

import {MoodNft} from "../src/MoodNft.sol";

import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract MoodNftTest is Test {
    DeployMoodNft deployer;
    MoodNft moodNft;

    address public USER = makeAddr("USER");
    address public USER1 = makeAddr("USER1");

    function setUp() external {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testCounterIsZeroOnStart() public view {
        assert(moodNft.getCounter() == 0);
    }

    function testMintNftisWork() public {
        vm.prank(USER);
        moodNft.mintNft();
        assert(moodNft.ownerOf(0) == USER);
    }

    function testStartMoodStateIsHappyAndFlipIsSad() public {
        vm.prank(USER);
        moodNft.mintNft();
        assert(uint256(moodNft.getIdToTokenSvg(0)) == 0);
        vm.prank(USER);
        moodNft.flipMoodNft(0);
        assert(uint256(moodNft.getIdToTokenSvg(0)) == 1);
    }

    function testFlipIsWork() public {
        vm.prank(USER);
        moodNft.mintNft();
        vm.prank(USER);
        moodNft.flipMoodNft(0);
    }

    function testFlipIsRevert() public {
        vm.prank(USER);
        moodNft.mintNft();
        vm.prank(USER1);
        vm.expectRevert(MoodNft.MOODNFT__YOUARENOTOWNER.selector);
        moodNft.flipMoodNft(0);
    }

    function testIsCorrectUriAfterFlip() public {
        vm.prank(USER);
        moodNft.mintNft();
        vm.prank(USER);
        moodNft.flipMoodNft(0);
        console.log(moodNft.getSadUri());
        // console.log(moodNft.getHappyUri());
    }
}

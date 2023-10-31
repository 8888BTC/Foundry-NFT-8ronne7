// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happSvg = vm.readFile("./img/Mood/Happy.svg");
        string memory sadSvg = vm.readFile("./img/Mood/Sad.svg");
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            transferBase64(happSvg),
            transferBase64(sadSvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function transferBase64(
        string memory svg
    ) public pure returns (string memory) {
        string memory startUri = "data:application/json;base64,";
        string memory endUri = string(
            Base64.encode(bytes(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(startUri, endUri));
    }
}

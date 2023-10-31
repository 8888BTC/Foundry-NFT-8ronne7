// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintNft is Script {
    string public constant tokenUri =
        "ipfs://bafkreicdyn4gexdoou3fmsuwwbtpnyshvp32xhqvefjm2zho4ilfnp5eua";

    function run() external {
        address recentlyContracts = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintTeddyNft(recentlyContracts);
    }

    function mintTeddyNft(address contracts) public {
        vm.startBroadcast();
        BasicNft(contracts).mintNft(tokenUri);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address recentlyContracts = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintMoodNftUsingConfig(recentlyContracts);
    }

    function mintMoodNftUsingConfig(address recentlyContracts) public {
        vm.startBroadcast();
        MoodNft(recentlyContracts).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function run() external {
        address recentlyContracts = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMoodNftUsingConfig(recentlyContracts);
    }

    function flipMoodNftUsingConfig(address recentlyContracts) public {
        vm.startBroadcast();
        MoodNft(recentlyContracts).flipMoodNft(0);
        vm.stopBroadcast();
    }
}

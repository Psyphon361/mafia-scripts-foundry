// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";

interface ITrainSkill {
    function trainSkill(uint8 trainType) external;
}

contract PLS_TrainSkillScript is Script {
    // PulseChain mainnet train kill skill contract address
    address constant PLS_KILL_SKILL_CA = 0xdC45E5469A8B6D020473F69fEC91C0f0e83a3308;

    function run(uint8 trainType) external {
        train(trainType);
    }

    function train(uint8 trainType) public {
        // Start broadcast
        vm.startBroadcast();

        // Create an instance of the contract
        ITrainSkill contractInstance = ITrainSkill(PLS_KILL_SKILL_CA);

        // Call the trainSkill function
        contractInstance.trainSkill(trainType);

        // Stop broadcast
        vm.stopBroadcast();
    }
}
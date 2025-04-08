// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";

interface ITrainSkill {
    function trainSkill(uint8 trainType) external;
}

contract BNB_TrainSkillScript is Script {
    // BNB mainnet train kill skill contract address
    address constant BNB_KILL_SKILL_CA = 0xa5dc2Cb4dC13f12d8464eaA862fAC00F19ADc84d;

    function run(uint8 trainType) external {
        train(trainType);
    }

    function train(uint8 trainType) public {
        // Start broadcast
        vm.startBroadcast();

        // Create an instance of the contract
        ITrainSkill contractInstance = ITrainSkill(BNB_KILL_SKILL_CA);

        // Call the trainSkill function
        contractInstance.trainSkill(trainType);

        // Stop broadcast
        vm.stopBroadcast();
    }
}
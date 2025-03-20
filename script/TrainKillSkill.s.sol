// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface ITrainSkill {
    function trainSkill(uint8 trainType) external;
}

contract TrainSkillScript is Script {
    // PulseChain mainnet contract address
    address constant CONTRACT_ADDRESS = 0xdC45E5469A8B6D020473F69fEC91C0f0e83a3308;
    uint8 BOTTLES_IN_BACKYARD = 0;
    uint8 DAY_AT_SHOOTING_RANGE = 1;
    uint8 HIRE_A_PERSONAL_TRAINER = 2;

    function run() external {
        train(DAY_AT_SHOOTING_RANGE);
    }

    function train(uint8 trainType) public {
        vm.startBroadcast();

        // Create an instance of the contract
        ITrainSkill contractInstance = ITrainSkill(CONTRACT_ADDRESS);

        // Call the trainSkill function
        contractInstance.trainSkill(trainType);

        // Stop broadcasting
        vm.stopBroadcast();
    }
}
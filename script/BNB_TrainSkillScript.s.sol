// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";

interface ITrainSkill {
    function trainSkill(uint8 trainType) external;
}
interface INickCar {
    function nickCar(uint8 carType, string calldata message, bytes calldata signature) external;
}

contract BNB_TrainSkillScript is Script {

    // BNB mainnet train kill skill contract address
    address constant BNB_KILL_SKILL_CA = 0xa5dc2Cb4dC13f12d8464eaA862fAC00F19ADc84d;
    
    // BNB mainnet nick car contract address
    address constant BNB_NICK_CAR_CA = 0x60B8e0dd9566b42F9CAa5538350aA0D29988373c;

    function run(uint8 trainType) external {
        train(trainType);
    }

    function runNickCar(uint8 carType, string calldata message, bytes calldata signature) external {
        nickCar(carType, message, signature);
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

    function nickCar(uint8 carType, string calldata message, bytes calldata signature) public {

        // Create contract instance
        INickCar contractInstance = INickCar(BNB_NICK_CAR_CA);

        // Encode the function call
        bytes memory callData = abi.encodeWithSelector(
            INickCar.nickCar.selector,
            carType,
            message,
            signature
        );

        // Triggerhappy:
        // "Set the gas for this fn. There is an issue with the nik car contract, where it runs out of gas.
        // "This amount seems to be enough. can remove this gas limit in the future and let foundry handle the gas if 
        // if this issue get sorted." 
        uint256 gasLimit = 2_000_000;

        // Start broadcast
        vm.startBroadcast();

        // Call the function with custom gas limit
        (bool callSuccess, ) = BNB_NICK_CAR_CA.call{gas: gasLimit}(callData);
        require(callSuccess, "nickCar call failed");

        // Stop broadcast
        vm.stopBroadcast();
    }
}
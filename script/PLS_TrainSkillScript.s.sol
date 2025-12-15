// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";

import "forge-std/console.sol";

interface ITrainSkill {
    function trainSkill(uint8 trainType) external;
}

interface INickCar {
    function nickCar(uint8 carType, string calldata message, bytes calldata signature) external;
}

interface IMafiaJail {
    function bustOut(address prisoner) external;
    function isUserInJail(address user) external view returns (bool);
    function jailedUntil(address user) external view returns (uint256);
}

contract PLS_TrainSkillScript is Script {

    // PulseChain mainnet train kill skill contract address
    address constant PLS_KILL_SKILL_CA = 0xdC45E5469A8B6D020473F69fEC91C0f0e83a3308;

    // PulseChain mainnet Nick Car contract address
    address constant PLS_NICK_CAR_CA = 0x2bf1EEaa4e1D7502AeF7f5beCCf64356eDb4a8c8;

    // PulseChain mainnet Jail Bust contract address
    address constant PLS_JAIL_BUST_CA = 0xDCD5E9c0b2b4E9Cb93677A258521D854b3A9f5A1;


    function run(uint8 trainType) external {
        train(trainType);
    }

    function runNickCar(uint8 carType, string calldata message, bytes calldata signature) external {
        nickCar(carType, message, signature);
    }

    function runBustOut(address prisoner) external {
        bustOut(prisoner);
    }

    function isUserInJail(address user) external {
       checkJailStatus(user);
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

    function nickCar(uint8 carType, string calldata message, bytes calldata signature) public {

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
        (bool callSuccess, ) = PLS_NICK_CAR_CA.call{gas: gasLimit}(callData);
        require(callSuccess, "nickCar call failed");

        // Stop broadcast
        vm.stopBroadcast();
    }

    function bustOut(address prisoner) public {
        require(prisoner != address(0), "Invalid prisoner address");

        vm.startBroadcast();

        // Encode the function call
        bytes memory callData = abi.encodeWithSelector(
            IMafiaJail.bustOut.selector,
            prisoner
        );

        uint256 gasLimit = 1_000_000;

        // Call the function with custom gas limit
        (bool callSuccess, ) = PLS_JAIL_BUST_CA.call{gas: gasLimit}(callData);
        require(callSuccess, "jailbust failed");


        vm.stopBroadcast();
    }

    function checkJailStatus(address prisoner) public view {
        require(prisoner != address(0), "Invalid address");

        IMafiaJail jailInstance = IMafiaJail(PLS_JAIL_BUST_CA);

        bool inJail = jailInstance.isUserInJail(prisoner);

        // log the result to read from stdout
        console.log(inJail);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/TaskChainToken.sol"; 

contract DeployToken is Script {
    function run() external {
        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy the Token contract
        TaskChainToken token = new TaskChainToken();

        // Optionally log the deployed address
        console.log("Token deployed at:", address(token));

        // Check and log the balance of the deployer (msg.sender)
        uint256 balance = token.balanceOf(msg.sender);
        console.log("Deployer balance:", balance);

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}

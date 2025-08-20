pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - The Solidity On-chain Verifier, which is generated via NoirJS/bb.js
import { HonkVerifier } from "../../../src/circuits/zk-jwt/honk-verifier/honk_vk.sol";

/**
 * @notice - Deployment script to deploy all SCs at once - on BASE Mainnet
 */
contract DeploymentForHonkVerifier_basescan is Script {
    HonkVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("base_mainnet");  // [NOTE]: foundry.toml - BASE Mainnet RPC URL
        //vm.createSelectFork("https://mainnet.base.org");

        uint256 deployerPrivateKey = vm.envUint("BASE_MAINNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Deploy the SCs
        //verifier = HonkVerifier(vm.envAddress("HonkVerifier_ON_BASE_MAINNET"));
        verifier = new HonkVerifier();

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Base Mainnet
        console.logString("Logs of the deployed-contracts on Base Mainnet");
        console.logString("\n");
        console.log("%s: %s", "HonkVerifier SC", address(verifier));
    }
}
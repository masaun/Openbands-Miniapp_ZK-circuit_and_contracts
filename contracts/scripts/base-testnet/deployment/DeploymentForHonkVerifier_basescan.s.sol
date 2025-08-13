pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - The Solidity On-chain Verifier, which is generated via NoirJS/bb.js
import { HonkVerifier } from "../../../src/circuits/zk-jwt/honk-verifier/honk_vk.sol";

/**
 * @notice - Deployment script to deploy all SCs at once - on BASE Mainnet
 */
contract DeploymentForHonkVerifier_basescan is Script {
    UltraVerifier public verifier;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("base_testnet");  // [NOTE]: foundry.toml - BASE Testnet RPC URL
        //vm.createSelectFork("hhttps://sepolia.base.org");
        
        uint256 deployerPrivateKey = vm.envUint("BASE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Deploy the SCs
        //verifier = HonkVerifier(vm.envAddress("HonkVerifier_ON_BASE_TESTNET"));
        verifier = new HonkVerifier();

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Base Mainnet
        console.logString("Logs of the deployed-contracts on Base Testnet");
        console.logString("\n");
        console.log("%s: %s", "HonkVerifier SC", address(verifier));
    }
}
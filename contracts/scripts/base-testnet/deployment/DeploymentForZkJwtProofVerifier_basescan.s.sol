pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - The Solidity On-chain Verifier, which is generated via NoirJS/bb.js
import { HonkVerifier } from "../../../src/circuits/zk-jwt/honk-verifier/honk_vk.sol";
import { ZkJwtProofVerifier } from "../../../src/circuits/zk-jwt/ZkJwtProofVerifier.sol";


/**
 * @notice - Deployment script to deploy the ZkJwtProofVerifier SC - on BASE Mainnet
 */
contract DeploymentForZkJwtProofVerifier_basescan is Script {
    HonkVerifier public verifier;
    ZkJwtProofVerifier public zkJwtProofVerifier;

    function setUp() public {}

    function run() public {

        vm.createSelectFork("https://mainnet.base.org"); // @dev - [NOTE]: Hardcoded the Base Mainnet RPC URL - Instead of using the environment variable via the foundry.toml
        //vm.createSelectFork('base-mainnet');

        uint256 deployerPrivateKey = vm.envUint("BASE_MAINNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Deploy SCs
        verifier = HonkVerifier(vm.envAddress("HONKVERIFIER_ON_BASE_MAINNET"));
        //verifier = new HonkVerifier();
        zkJwtProofVerifier = new ZkJwtProofVerifier(verifier);

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on BASE Mainnet
        console.logString("Logs of the deployed-contracts on BASE Mainnet");
        console.logString("\n");
        console.log("%s: %s", "HonkVerifier SC", address(verifier));
        console.logString("\n");
        console.log("%s: %s", "ZkJwtProofVerifier SC", address(zkJwtProofVerifier));
    }
}

pragma solidity ^0.8.17;

import "forge-std/Script.sol";

/// @dev - ZK (Ultraplonk) circuit, which is generated in Noir.
import { ZkJwtProofVerifier } from "../../../src/circuits/zk-jwt/ZkJwtProofVerifier.sol";
import { ZkJwtProofManager } from "../../../src/circuits/zk-jwt/ZkJwtProofManager.sol";


/**
 * @notice - Deployment script to deploy the ZkJwtProofManager SC - on BASE Mainnet
 */
contract DeploymentForZkJwtProofManager_basescan is Script {
    ZkJwtProofVerifier public zkJwtProofVerifier;
    ZkJwtProofManager public zkJwtProofManager;

    function setUp() public {}

    function run() public {

        vm.createSelectFork("https://mainnet.base.org"); // @dev - [NOTE]: Hardcoded the Base Mainnet RPC URL - Instead of using the environment variable via the foundry.toml
        //vm.createSelectFork('base-mainnet');

        uint256 deployerPrivateKey = vm.envUint("BASE_TESTNET_PRIVATE_KEY");
        //uint256 deployerPrivateKey = vm.envUint("LOCALHOST_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //vm.startBroadcast();

        /// @dev - Deploy SCs
        zkJwtProofVerifier = ZkJwtProofVerifier(vm.envAddress("ZK_JWT_PROOF_VERIFIER_ON_BASE_TESTNET"));
        //zkJwtProofVerifier = new ZkJwtProofVerifier(verifier);
        zkJwtProofManager = new ZkJwtProofManager(zkJwtProofVerifier);

        vm.stopBroadcast();

        /// @dev - Logs of the deployed-contracts on Base Testnet
        console.logString("Logs of the deployed-contracts on Base Testnet");
        console.logString("\n");
        console.log("%s: %s", "ZkJwtProofVerifier SC", address(zkJwtProofVerifier));
        console.logString("\n");
        console.log("%s: %s", "ZkJwtProofManager SC", address(zkJwtProofManager));
    }
}
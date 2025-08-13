echo "Compile the smart contract files..."
sh compileContracts.sh

echo "Load the environment variables from the .env file..."
. ./.env

echo "Deploying & Verifying the ZkJwtProofVerifier contract on Base Testnet (via BaseScan)..."
forge script scripts/base-testnet/deployment/DeploymentForZkJwtProofVerifier_basescan.s.sol --slow --multi --broadcast --private-key ${BASE_TESTNET_PRIVATE_KEY} --verify --etherscan-api-key ${BASESCAN_API_KEY}
# Smart Contracts

## Installation

- Run the `forge-install.sh`:
```bash
cd contracts
sh forge-install.sh
```

Or,

- If there is modules under the `./contracts/lib/` directory, they should be removed in advance:
```bash
cd contracts
rm -rf lib/* 
```

- Install the `foundry-noir-helper` libary:
```bash
forge install 0xnonso/foundry-noir-helper --no-commit
```

<br>

## Compile Smart Contracts

- Compile the smart contracts:
  - And then, the `artifacts` (icl. `ABIs`) would be copied and pasted into the `./app/lib/smart-contracts/evm/smart-contracts/artifacts` directory:
```bash
cd contracts
sh compileContracts.sh
```

<br>

## Smart Contract Deployment on BASE `testnet`

- NOTE: This script file must be run from the `root` directory of this project, where is the location of `.env` file.
```bash
cd contracts
sh scripts/base-testnet/deployment/deploymentScript_HonkVerifier_via_basescan.sh
```
```bash
cd contracts
sh scripts/base-testnet/deployment/deploymentScript_ZkJwtProofVerifier_via_basescan.sh
```
```bash
cd contracts
sh scripts/base-testnet/deployment/deploymentScript_ZkJwtProofManager_via_basescan.sh
```

<br>

## Smart Contract Deployment on BASE `mainnet`

- NOTE: This script file must be run from the `root` directory of this project, where is the location of `.env` file.
```bash
cd contracts
sh scripts/base-mainnet/deployment/deploymentScript_HonkVerifier_via_basescan.sh
```
```bash
cd contracts
sh scripts/base-mainnet/deployment/deploymentScript_ZkJwtProofVerifier_via_basescan.sh
```
```bash
cd contracts
sh scripts/base-mainnet/deployment/deploymentScript_ZkJwtProofManager_via_basescan.sh
```


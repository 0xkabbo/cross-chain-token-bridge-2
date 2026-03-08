# Cross-Chain Token Bridge

This repository provides a secure, production-ready framework for bridging ERC-20 tokens between two EVM chains. It utilizes a "Lock/Unlock" mechanism on the source chain and a "Mint/Burn" mechanism on the destination chain.

## Architecture
The bridge consists of two main smart contracts:
1. **BridgeSource**: Users lock their tokens here. The contract emits a `Deposit` event.
2. **BridgeDestination**: An off-chain relayer picks up the event and submits a signed message to this contract to mint a wrapped version of the token.



## Features
* **Signature Verification**: Uses EIP-712 typed data signing for secure off-chain authorizations.
* **Replay Protection**: Implements nonces to prevent the same bridge transaction from being executed twice.
* **Role-Based Access**: Specialized roles for relayers and administrators.

## Deployment
1. Deploy `BridgeSource.sol` on the Origin chain (e.g., Ethereum).
2. Deploy `BridgeDestination.sol` on the Target chain (e.g., Polygon).
3. Configure the Relayer address on both contracts.

## License
MIT

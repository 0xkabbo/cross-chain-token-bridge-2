// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BridgeBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeSource is BridgeBase {
    IERC20 public token;

    event Deposit(address indexed user, uint256 amount, uint256 nonce);

    uint256 public nextNonce;

    constructor(address _token, address _relayer) BridgeBase(_relayer) {
        token = IERC20(_token);
    }

    function lock(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
        emit Deposit(msg.sender, amount, nextNonce);
        nextNonce++;
    }

    function unlock(address user, uint256 amount, uint256 nonce, bytes calldata signature) external {
        bytes32 messageHash = keccak256(abi.encodePacked(user, amount, nonce));
        require(_verifySignature(messageHash, signature), "Invalid signature");
        require(!processedMessages[messageHash], "Already processed");

        processedMessages[messageHash] = true;
        token.transfer(user, amount);
    }
}

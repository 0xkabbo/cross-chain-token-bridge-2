// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract BridgeBase {
    using ECDSA for bytes32;

    address public relayer;
    mapping(bytes32 => bool) public processedMessages;

    constructor(address _relayer) {
        relayer = _relayer;
    }

    function _verifySignature(bytes32 messageHash, bytes memory signature) internal view returns (bool) {
        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(messageHash);
        return ethSignedMessageHash.recover(signature) == relayer;
    }
}

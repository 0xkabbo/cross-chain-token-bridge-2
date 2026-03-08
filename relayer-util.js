const { ethers } = require("ethers");

async function signBridgeMessage(relayerPrivateKey, user, amount, nonce) {
    const wallet = new ethers.Wallet(relayerPrivateKey);
    const messageHash = ethers.solidityPackedKeccak256(
        ["address", "uint256", "uint256"],
        [user, amount, nonce]
    );
    
    const signature = await wallet.signMessage(ethers.toBeArray(messageHash));
    return signature;
}

module.exports = { signBridgeMessage };

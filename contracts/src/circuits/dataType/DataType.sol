pragma solidity >=0.8.21;

library DataType {

    struct PublicInput {
        // @dev - Genuine public inputs, which is emitted via zkJWT circuit
        //string jwtPubkeyModulusLimbs;
        string domain;
        bytes32 nullifierHash;

        // @dev - Not genuine public inputs, which is emitted via zkJWT circuit. This is for the validation purpose.
        string emailHash;
        address walletAddress;
        string createdAt;     // @dev - ISO String format (i.e. "2025-07-16T07:20:30.000Z")
        //uint256 createdAt;  // @dev - block.timestamp
    }

}
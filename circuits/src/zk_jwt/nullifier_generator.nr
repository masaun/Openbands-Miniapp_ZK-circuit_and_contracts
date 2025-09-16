use poseidon::poseidon2;                 // @dev - For the Noir/Nargo v1.0.0-beta.11, we need to use this module for Poseidon hash
//use std::hash::poseidon2::Poseidon2;   // @dev - For the Noir/Nargo v1.0.0-beta.6, we are still able to use this module for Poseidon hash
use std::hash::pedersen_hash;

/** 
 * @notice - Calculate a nullifier using Poseidon2 hash
 */
pub fn generate_nullifier_with_poseidon2(inputs: [Field; 3]) -> Field {   // @dev - For the Noir/Nargo v1.0.0-beta.11
//pub fn generate_nullifier_with_poseidon2(inputs: [Field; _]) -> Field { // @dev - For the Noir/Nargo v1.0.0-beta.6
    // @dev - For the Noir/Nargo v1.0.0-beta.11
    let nullifier_hash = poseidon2::Poseidon2::hash(
        inputs,
        inputs.len() as u32
    );

    // @dev - For the Noir/Nargo v1.0.0-beta.6
    // let nullifier_hash = Poseidon2::hash(
    //     inputs,
    //     inputs.len() as u32
    // );

    nullifier_hash
}

/** 
 * @notice - Calculate a nullifier using Pedersen hash
 */
pub fn generate_nullifier_with_pedersen(inputs: [Field; 3]) -> Field {   // @dev - For the Noir/Nargo v1.0.0-beta.11
//pub fn generate_nullifier_with_pedersen(inputs: [Field; _]) -> Field { // @dev - For the Noir/Nargo v1.0.0-beta.6
    let nullifier_hash = pedersen_hash(
        inputs
    );
    nullifier_hash
}
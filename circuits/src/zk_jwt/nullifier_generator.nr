use std::hash::poseidon2::Poseidon2;
use std::hash::pedersen_hash;

/** 
 * @notice - Calculate a nullifier using Poseidon2
 */
pub fn generate_nullifier_with_poseidon2(inputs: [Field; _]) -> Field {
    let nullifier_hash = Poseidon2::hash(
        inputs,
        inputs.len() as u32
    );
    nullifier_hash
}

/** 
 * @notice - Calculate a nullifier using Pedersen hash
 */
pub fn generate_nullifier_with_pedersen(inputs: [Field; _]) -> Field {
    let nullifier_hash = pedersen_hash(
        inputs
    );
    nullifier_hash
}
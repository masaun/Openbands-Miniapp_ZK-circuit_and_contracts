use crate::{
    main,
    MAX_PARTIAL_DATA_LENGTH, MAX_DOMAIN_LENGTH
};

use super::test_input_data::{
    PARTIAL_DATA,
    PARTIAL_HASH,
    FULL_DATA_LENGTH,
    BASE64_DECODE_OFFSET,
    JWT_PUBKEY_MODULUS_LIMBS,
    JWT_PUBKEY_REDC_PARAMS_LIMBS,
    JWT_SIGNATURE_LIMBS,
    DOMAIN
};

#[test]
pub fn test_main() {
    // Test cases for the main function
    let partial_data: BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH> = PARTIAL_DATA;
    let partial_hash: [u32; 8] = PARTIAL_HASH;
    let full_data_length: u32 = FULL_DATA_LENGTH;
    let base64_decode_offset: u32 = BASE64_DECODE_OFFSET;
    let jwt_pubkey_modulus_limbs: [u128; 18] = JWT_PUBKEY_MODULUS_LIMBS;
    let jwt_pubkey_redc_params_limbs: [u128; 18] = JWT_PUBKEY_REDC_PARAMS_LIMBS;
    let jwt_signature_limbs: [u128; 18] = JWT_SIGNATURE_LIMBS;
    let domain: BoundedVec<u8, MAX_DOMAIN_LENGTH> = DOMAIN;

    let result = main(
        partial_data,
        partial_hash,
        full_data_length,
        base64_decode_offset,
        jwt_pubkey_modulus_limbs,
        jwt_pubkey_redc_params_limbs,
        jwt_signature_limbs,
        domain,
    );
    println(f"result: {result}\n");

    // Assert the expected result
    //assert_eq!(result, /* expected result */);
}

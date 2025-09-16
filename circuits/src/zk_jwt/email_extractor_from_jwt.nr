use jwt::JWT;

use crate::{MAX_EMAIL_LENGTH, MAX_PARTIAL_DATA_LENGTH};

use crate::zk_jwt::{
    extra_zeros_removal::{remove_extra_zeros_from_partial_data},
    utils::{decimal_string_to_field, get_domain_start_index_in_email},
    nullifier_generator::{
        generate_nullifier_with_poseidon2,
        generate_nullifier_with_pedersen,
    },
};


/**
 * @notice - Extract email from JWT and return it as BoundedVec<u8, MAX_EMAIL_LENGTH>
 */
pub fn extract_email_from_jwt_in_vec(
    partial_data: BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH>,
    partial_hash: [u32; 8],
    full_data_length: u32,
    base64_decode_offset: u32,
    jwt_pubkey_modulus_limbs: [u128; 18],
    jwt_pubkey_redc_params_limbs: [u128; 18],
    jwt_signature_limbs: [u128; 18],
    //domain: pub BoundedVec<u8, MAX_DOMAIN_LENGTH>
    //ephemeral_pubkey: pub Field,
    //ephemeral_pubkey_salt: Field,
    //ephemeral_pubkey_expiry: pub u32
) -> BoundedVec<u8, MAX_EMAIL_LENGTH> {
    // @dev - Remove extra zeros, which are added to an original "partial_data" when it is inputted from the frontend, from an original "partial_data"
    let _partial_data: BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH> = unsafe { remove_extra_zeros_from_partial_data(partial_data) };
    println(f"_partial_data: {_partial_data}\n");

    // Init JWT struct and verify signature
    let jwt = JWT::init_with_partial_hash(
        //partial_data,
        _partial_data,
        partial_hash,
        full_data_length,
        base64_decode_offset,
        jwt_pubkey_modulus_limbs,
        jwt_pubkey_redc_params_limbs,
        jwt_signature_limbs,
    );
    jwt.verify();

    jwt.get_claim_string("email".as_bytes())
}

/**
 * @notice - Convert email in BoundedVec<u8, MAX_EMAIL_LENGTH> to Field
 */
pub fn convert_email_vec_to_field(email: BoundedVec<u8, MAX_EMAIL_LENGTH>) -> Field {
    let email_bytes: [u8; MAX_EMAIL_LENGTH] = email.storage();
    println(f"email_bytes: {email_bytes}\n");
    let email_field: Field = Field::from_be_bytes(email_bytes);
    println(f"email_field: {email_field}\n");
    email_field
}
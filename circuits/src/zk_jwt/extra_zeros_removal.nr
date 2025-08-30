use crate::{ MAX_PARTIAL_DATA_LENGTH };

/**
 * @dev - Remove extra zeros, which are added to an original "partial_data" when it is inputted from the frontend, from an original "partial_data"
 */
unconstrained pub fn remove_extra_zeros_from_partial_data(partial_data: BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH>) -> BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH> {
    let mut start_index = 0;
    let mut zero_start_index = 0;
    let len = partial_data.len();
    for i in 0..len {
        if partial_data.storage()[i] == 0 {
            zero_start_index = i;
            start_index = i + 1;
            break;
        }
    }

    let mut new_vector: BoundedVec<u8, MAX_PARTIAL_DATA_LENGTH> = BoundedVec::new();
    for c in 0..len {
        if partial_data.storage()[c] > 0 {
            new_vector.push(partial_data.storage()[c]);
        } else if partial_data.storage()[c] == 0 {
            break;
        }
    }
    println(f"new_vector (which is a recreated partial_data from an original partial_data): {new_vector}\n");

    new_vector
}



// pub fn array_to_bounded_vec<T, let N: u32>(array: [T; N]) -> BoundedVec<T, N>
// where
//     T: Empty + Eq,
// {
//     let mut len = 0;
//     for elem in array {
//         if !is_empty(elem) {
//             len += 1;
//         }
//     }
//     BoundedVec::from_parts_unchecked(array, len)
// }

// pub fn is_empty<T>(item: T) -> bool
// where
//     T: Empty + Eq,
// {
//     item.eq(T::empty())
// }

// trait Empty {
//     fn empty() -> Self;
// }

// impl Empty for u8 {
//     fn empty() -> Self {
//         0
//     }
// }
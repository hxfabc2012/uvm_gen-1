// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_CONSTANTS_SV__
`define __UVMA_{{ name.upper() }}_CONSTANTS_SV__


const bit                       uvma_{{ name }}_big_endian      =             1; ///< Endianness for bit ordering.
const int unsigned              uvma_{{ name }}_training_length =            64; ///< Training sequence length (bits).
const int unsigned              uvma_{{ name }}_syncing_length  =            32; ///< Syncing consecutive edge count.
const int unsigned              uvma_{{ name }}_trn_length      =    32 + 2 + 2; ///< Full length of transaction (bits).
const uvma_{{ name }}_tail_b_t  uvma_{{ name }}_tail_symbol     =         2'b11; ///< Data for transaction tails.
const uvma_{{ name }}_data_b_t  uvma_{{ name }}_idle_data       = 32'h0000_0000; ///< Data for idle transaction 'payload'.


`endif // __UVMA_{{ name.upper() }}_CONSTANTS_SV__

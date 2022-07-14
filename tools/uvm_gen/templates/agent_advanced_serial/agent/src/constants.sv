// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_CONSTANTS_SV__
`define __UVMA_{{ upper(name) }}_CONSTANTS_SV__


const int unsigned              uvma_{{ name }}_training_length =            64; ///<
const int unsigned              uvma_{{ name }}_trn_length      =    32 + 2 + 2; ///<
const uvma_{{ name }}_sync_b_t  uvma_{{ name }}_tail_symbol     =         2'b11; ///<
const uvma_{{ name }}_data_b_t  uvma_{{ name }}_idle_data       = 32'h0707_0707; ///<


`endif // __UVMA_{{ upper(name) }}_CONSTANTS_SV__

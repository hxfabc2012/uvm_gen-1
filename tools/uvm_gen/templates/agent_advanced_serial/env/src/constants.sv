// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_CONSTANTS_SV__
`define __UVME_{{ name.upper() }}_ST_CONSTANTS_SV__


const int unsigned uvme_{{ name }}_st_rand_stim_default_num_seq_items =    10; ///< Default number of Sequence Items generated by uvme_{{ name }}_st_rand_stim_vseq_c in each direction.
const int unsigned uvme_{{ name }}_st_rand_stim_sqr_priority          = 1_000; ///< Sequencer priority for uvme_{{ name }}_st_rand_stim_vseq_c Sequence Items.


`endif // __UVME_{{ name.upper() }}_ST_CONSTANTS_SV__

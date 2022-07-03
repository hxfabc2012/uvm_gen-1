// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_TDEFS_SV__
`define __UVME_{{ upper(name) }}_ST_TDEFS_SV__


// Scoreboard specialization
typedef uvml_sb_simplex_c #(
   .T_ACT_TRN(uvma_{{ name }}_mon_trn_c)
) uvme_{{ name }}_st_sb_simplex_c;


`endif // __UVME_{{ upper(name) }}_ST_TDEFS_SV__

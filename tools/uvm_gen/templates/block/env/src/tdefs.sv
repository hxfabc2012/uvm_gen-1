// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_TDEFS_SV__
`define __UVME_${name_uppercase}_TDEFS_SV__


// Scoreboard specialization
typedef uvme_sb_simplex_c #(
   .T_ACT_TRN(uvma_${name}_dp_out_mon_trn_c)
) uvme_${name}_sb_simplex_c;

// Add tdefs, enums and structs here
// Ex: typedef bit [(`UVME_${name_uppercase}_ABC_MAX_WIDTH-1):0]  uvme_${name}_abc_b_t;
// Ex: typedef enum {
//        UVME_${name_uppercase}_MY_ABC
//     } uvme_${name}_my_enum;
// Ex: typedef struct {
//        bit [2:0]  abc;
//        logic      xyz;
//     } uvme_${name}_my_struct;


`endif // __UVME_${name_uppercase}_TDEFS_SV__

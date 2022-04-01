// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__
`define __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__


/**
 * Module wrapper for ${name_normal_case} RTL DUT.  All ports are SV interfaces.
 */
module uvmt_${name}_st_dut_wrap(
   uvma_${name}_if  ${name_1}_if,
   uvma_${name}_if  ${name_2}_if
);
   
   // TODO Instantiate Device Under Test (DUT)
   //      Ex: ${name}_st_top  dut(
   //             .abc(${name_1}_if.abc),
   //             .xyz(${name_2}_if.xyz),
   //          );
   
endmodule : uvmt_${name}_st_dut_wrap


`endif // __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__

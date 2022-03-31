// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__
`define __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__


/**
 * Module implementing buffer connecting active and passive ${name_normal_case} UVM Agent interfaces.
 */
module uvmt_${name}_st_dut_wrap(
   uvma_${name}_if  active_if ,
   uvma_${name}_if  passive_if
);

   // TODO Connect interfaces via buffers to avoid race condition at scoreboard.
   //      Ex: reg abc;
   //          passive_if.abc = abc;
   //          always @(active_if.clk) begin
   //             abc = active_if.abc;
   //          end

endmodule : uvmt_${name}_st_dut_wrap


`endif // __UVMT_${name_uppercase}_ST_DUT_WRAP_SV__

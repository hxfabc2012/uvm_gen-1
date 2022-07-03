// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name_uppercase }}_ST_DUT_WRAP_SV__
`define __UVMT_{{ name_uppercase }}_ST_DUT_WRAP_SV__


/**
 * Module implementing buffer connecting {{ mode_1 }} and {{ mode_2 }} {{ name_proper }} UVM Agent interfaces.
 */
module uvmt_{{ name }}_st_dut_wrap (
   uvma_{{ name }}_if  {{ mode_1 }}_if , ///< Active agent interface
   uvma_{{ name }}_if  {{ mode_2 }}_if ///< Passive agent interface
);

   // TODO Connect interfaces via buffers to avoid race condition at scoreboard.
   //      Ex: reg abc;
   //          {{ mode_2 }}_if.abc = abc;
   //          always @({{ mode_1 }}_if.clk) begin
   //             abc = {{ mode_1 }}_if.abc;
   //          end

endmodule : uvmt_{{ name }}_st_dut_wrap


`endif // __UVMT_{{ name_uppercase }}_ST_DUT_WRAP_SV__

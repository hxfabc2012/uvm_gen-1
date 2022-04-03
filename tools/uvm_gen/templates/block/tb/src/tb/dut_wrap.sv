// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_DUT_WRAP_SV__
`define __UVMT_${name_uppercase}_DUT_WRAP_SV__


/**
 * Module wrapper for ${name_normal_case} Block DUT.  All ports are SV interfaces.
 */
module uvmt_${name}_dut_wrap (
   uvma_${name}_cp_if      cp_if    , ///< Control plane interface
   uvma_${name}_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_${name}_dp_out_if  dp_out_if, ///< Data plane output interface
   uvmt_${name}_probe_if   probe_if   ///< Misc. signals
);

   // \/ CODE BELOW IS RESPONSABILITY OF DESIGNERS \/

   // TODO Instantiate Device Under Test (DUT) and connect it to the interfaces signals
   //      Ex: ${name}_top  dut (
   //             .clk    (cp_if.clk),
   //             .reset_n(cp_if.reset_n),
   //             .i_data(dp_in_if.data),
   //             .o_data(dp_out_if.data),
   //             ...
   //          );

   // TODO Connect probe interface signals to design
   //      Ex: assign probe_if.abc = dut.abc;

   // /\ CODE ABOVE IS RESPONSABILITY OF DESIGNERS /\

endmodule : uvmt_${name}_dut_wrap


`endif // __UVMT_${name_uppercase}_DUT_WRAP_SV__

// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_DUT_CHKR_SV__
`define __UVMT_${name_uppercase}_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for ${name_normal_case} Block DUT wrapper.  All ports are SV interfaces.
 * This module must be bound to the design in a test bench.
 */
module uvmt_${name}_dut_chkr (
   uvma_${name}_cp_if      cp_if    , ///< Control plane interface
   uvma_${name}_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_${name}_dp_out_if  dp_out_if, ///< Data plane output interface
   uvmt_${name}_probe_if   probe_if   ///< Misc. signals
);

   // TODO Add assertions to uvmt_${name}_dut_chkr

endmodule : uvmt_${name}_dut_chkr


`endif // __UVMT_${name_uppercase}_DUT_CHKR_SV__

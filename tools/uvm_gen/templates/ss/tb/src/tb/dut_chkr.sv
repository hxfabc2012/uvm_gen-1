// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_DUT_CHKR_SV__
`define __UVMT_${name_uppercase}_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for ${name_normal_case} Sub-System DUT wrapper.  All ports are SV interfaces.
 * This module must be bound to the design in a test bench.
 */
module uvmt_${name}_dut_chkr (
   uvma_${ral_agent_type}_if  ${ral_agent_name}_if, ///< Register access interface
   uvmt_${name}_probe_if  probe_if ///< Misc. signals
);

   // TODO Add assertions to uvmt_${name}_dut_chkr

endmodule : uvmt_${name}_dut_chkr


`endif // __UVMT_${name_uppercase}_DUT_CHKR_SV__

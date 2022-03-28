// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${name_uppercase}_DUT_CHKR_SV__
`define __UVMT_${name_uppercase}_DUT_CHKR_SV__


/**
 * Module encapsulating assertions for ${name_normal_case} RTL DUT wrapper.  All ports are SV interfaces.
 */
module uvmt_${name}_dut_chkr(
   uvma_${ral_agent_type}_if  ${ral_agent_type}_if,
   uvmt_${name}_probe_if  probe_if
);
   
   // TODO Add assertions to uvmt_${name}_dut_chkr
   
endmodule : uvmt_${name}_dut_chkr


`endif // __UVMT_${name_uppercase}_DUT_CHKR_SV__

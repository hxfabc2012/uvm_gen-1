// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CHKR_SV__
`define __UVME_${name_uppercase}_CHKR_SV__


/**
 * Encapsulates assertions targeting uvme_${name} interfaces.
 * This module must be bound to interfaces in a test bench.
 */
module uvme_${name}_chkr (
   uvma_${ral_agent_type}_if  ${ral_agent_name}_if ///< Register access interface
);

   // TODO Add assertions to uvme_$[name}_chkr

endmodule : uvme_${name}_chkr


`endif // __UVME_${name_uppercase}_CHKR_SV__

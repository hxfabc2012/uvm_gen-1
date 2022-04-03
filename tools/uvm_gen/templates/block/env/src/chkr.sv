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
   uvma_${name}_cp_if      cp_if    , ///< Control plane interface
   uvma_${name}_dp_in_if   dp_in_if , ///< Data plane input interface
   uvma_${name}_dp_out_if  dp_out_if  ///< Data plane output interface
);

   // TODO Add assertions to uvme_$[name}_chkr

endmodule : uvme_${name}_chkr


`endif // __UVME_${name_uppercase}_CHKR_SV__

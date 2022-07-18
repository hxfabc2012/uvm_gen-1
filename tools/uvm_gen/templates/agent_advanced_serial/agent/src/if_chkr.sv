// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_CHKR_SV__
`define __UVMA_{{ name.upper() }}_CHKR_SV__


/**
 * Encapsulates assertions targeting uvma_{{ name }}_if.
 * This module must be bound to an interface in a test bench.
 */
module uvma_{{ name }}_chkr(
   uvma_{{ name }}_if  {{ name }}_if ///< Target interface handle
);

   // TODO Add assertions to uvma_{{ name }}_chkr

endmodule : uvma_{{ name }}_chkr


`endif // __UVMA_{{ name.upper() }}_CHKR_SV__

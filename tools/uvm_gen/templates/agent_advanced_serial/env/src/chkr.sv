// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_CHKR_SV__
`define __UVME_{{ name.upper() }}_ST_CHKR_SV__


/**
 * Encapsulates assertions targeting uvme_${name}_st interfaces.
 * This module must be bound to interfaces in a test bench.
 */
module uvme_{{ name }}_st_chkr (
      uvma_{{ name }}_if  {{ mode_1 }}_if, ///<  {{ mode_1.upper() }} Agent interface
      uvma_{{ name }}_if  {{ mode_2 }}_if, ///<  {{ mode_2.upper() }} Agent interface
      uvma_{{ name }}_if  passive_if       ///< Passive Agent interface.
);

   // TODO Add assertions to uvme_{{ name }}_st_chkr

endmodule : uvme_{{ name }}_st_chkr


`endif // __UVME_{{ name.upper() }}_ST_CHKR_SV__

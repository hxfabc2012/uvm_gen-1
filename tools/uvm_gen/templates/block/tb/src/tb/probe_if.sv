// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_PROBE_IF_SV__
`define __UVMT_${name_uppercase}_PROBE_IF_SV__


/**
 * Interface encapsulating all extra signals to/from ${name_normal_case} Block design hierarchy.
 */
interface uvmt_${name}_probe_if;

   import uvma_${name}_cp_pkg    ::*;
   import uvma_${name}_dp_in_pkg ::*;
   import uvma_${name}_dp_out_pkg::*;
   import uvme_${name}_pkg       ::*;

   // TODO Add signals to uvmt_${name}_probe_if
   //      Ex: logic  probed_wire_a; ///< Describe me!

endinterface : uvmt_${name}_probe_if


`endif // __UVMT_${name_uppercase}_PROBE_IF_SV__

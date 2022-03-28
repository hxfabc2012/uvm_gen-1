// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${name_uppercase}_PROBE_IF_SV__
`define __UVMT_${name_uppercase}_PROBE_IF_SV__


/**
 * Interface encapsulating all extra signals to/from design hierarchy.
 */
interface uvmt_${name}_probe_if;
   
   import uvme_${name}_pkg::*;
   
   // TODO Add signals to uvmt_${name}_probe_if
   //      Ex: logic  probed_wire_a;
   
endinterface : uvmt_${name}_probe_if


`endif // __UVMT_${name_uppercase}_PROBE_IF_SV__

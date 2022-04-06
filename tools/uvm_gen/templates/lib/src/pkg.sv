// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_${name_uppercase}_PKG_SV__
`define __UVML_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_${name}_macros.svh"


/**
 * Encapsulates all the types needed for the ${name_normal_case} library.
 */
package uvml_${name}_pkg;

   import uvm_pkg::*;

   // Constants / Structs / Enums
   `include "uvml_${name}_tdefs.sv"
   `include "uvml_${name}_constants.sv"

endpackage : uvml_${name}_pkg


`endif // __UVML_${name_uppercase}_PKG_SV__

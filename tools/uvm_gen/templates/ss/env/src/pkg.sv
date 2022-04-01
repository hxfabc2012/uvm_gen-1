// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_PKG_SV__
`define __UVME_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvml_ral_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvma_reset_macros.svh"
`include "uvma_${ral_agent_type}_macros.svh"
`include "uvme_${name}_macros.svh"

// Interface(s)


 /**
 * Encapsulates all the types of the ${name_normal_case} Sub-System UVM environment.
 */
package uvme_${name}_pkg;

   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_clk_pkg  ::*;
   import uvma_reset_pkg::*;
   import uvma_${ral_agent_type}_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_${name}_tdefs.sv"
   `include "uvme_${name}_constants.sv"

   // Register Abstraction Layer
   `include "uvme_${name}_reg_block.sv"

   // Objects
   `include "uvme_${name}_cfg.sv"
   `include "uvme_${name}_cntxt.sv"

   // Predictor
   `include "uvme_${name}_prd.sv"

   // Environment components
   `include "uvme_${name}_cov_model.sv"
   `include "uvme_${name}_sb.sv"
   `include "uvme_${name}_vsqr.sv"
   `include "uvme_${name}_env.sv"

   // Sequences
   `include "uvme_${name}_vseq_lib.sv"

endpackage : uvme_${name}_pkg


// Module(s) / Checker(s)
`ifdef UVME_${name_uppercase}_INC_CHKR
`include "uvme_${name}_chkr.sv"
`endif


`endif // __UVME_${name_uppercase}_PKG_SV__

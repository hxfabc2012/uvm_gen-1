// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_PKG_SV__
`define __UVME_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_sb_macros.sv"
`include "uvml_ral_macros.sv"
`include "uvma_${clk_agent_type}_macros.sv"
`include "uvma_${reset_agent_type}_macros.sv"
`include "uvma_${ral_agent_type}_macros.sv"
`include "uvme_${name}_macros.sv"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of driving/monitoring and verifying the behavior of
 * a ${name_normal_case} design.
 */
package uvme_${name}_pkg;
   
   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_${clk_agent_type}_pkg::*;
   import uvma_${reset_agent_type}_pkg::*;
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
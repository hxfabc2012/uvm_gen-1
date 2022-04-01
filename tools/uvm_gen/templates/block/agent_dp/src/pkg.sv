// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_DP_PKG_SV__
`define __UVMA_${name_uppercase}_DP_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_${name}_dp_macros.svh"

// Interface(s)
`ifndef UVMA_${name_uppercase}_DP_NO_IF
`include "uvma_${name}_dp_if.sv"
`endif


/**
 * Encapsulates all the types needed for a UVM agent capable of driving and monitoring a ${name_normal_case} Data Path interface.
 */
package uvma_${name}_dp_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_${name}_dp_tdefs.sv"
   `include "uvma_${name}_dp_constants.sv"

   // Objects
   `include "uvma_${name}_dp_cfg.sv"
   `include "uvma_${name}_dp_cntxt.sv"

   // High-level transactions
   `include "uvma_${name}_dp_seq_item.sv"
   `include "uvma_${name}_dp_mon_in_trn.sv"
   `include "uvma_${name}_dp_mon_out_trn.sv"

   // Agent components
   `include "uvma_${name}_dp_sqr.sv"
   `include "uvma_${name}_dp_drv.sv"
   `include "uvma_${name}_dp_mon.sv"
   `include "uvma_${name}_dp_cov_model.sv"
   `include "uvma_${name}_dp_logger.sv"
   `include "uvma_${name}_dp_agent.sv"

   // Sequences
   `include "uvma_${name}_dp_seq_lib.sv"

endpackage : uvma_${name}_dp_pkg


// Module(s) / Checker(s)
`ifdef UVMA_${name_uppercase}_DP_INC_IF_CHKR
`include "uvma_${name}_dp_if_chkr.sv"
`endif


`endif // __UVMA_${name_uppercase}_DP_PKG_SV__

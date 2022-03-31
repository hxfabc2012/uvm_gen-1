// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_PKG_SV__
`define __UVMA_${name_uppercase}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_logs_macros.sv"
`include "uvma_${name}_macros.svh"

// Interface(s)
`ifndef UVMA_${name_uppercase}_NO_IF
`include "uvma_${name}_if.sv"
`endif


/**
 * Encapsulates all the types needed for a UVM agent capable of driving and monitoring a ${name_normal_case} interface.
 */
package uvma_${name}_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_${name}_tdefs.sv"
   `include "uvma_${name}_constants.sv"

   // Objects
   `include "uvma_${name}_cfg.sv"
   `include "uvma_${name}_cntxt.sv"

   // High-level transactions
   `include "uvma_${name}_seq_item.sv"
   `include "uvma_${name}_mon_trn.sv"

   // Agent components
   `include "uvma_${name}_sqr.sv"
   `include "uvma_${name}_drv.sv"
   `include "uvma_${name}_mon.sv"
   `include "uvma_${name}_cov_model.sv"
   `include "uvma_${name}_logger.sv"
   `include "uvma_${name}_agent.sv"

   // Sequences
   `include "uvma_${name}_base_seq.sv"
   // TODO Add sequences to uvma_${name}_pkg

endpackage : uvma_${name}_pkg


// Module(s) / Checker(s)
`ifdef UVMA_${name_uppercase}_INC_IF_CHKR
`include "uvma_${name}_if_chkr.sv"
`endif


`endif // __UVMA_${name_uppercase}_PKG_SV__

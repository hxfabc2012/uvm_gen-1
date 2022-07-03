// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_PKG_SV__
`define __UVMA_{{ upper(name) }}_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_mem_macros.svh"
`include "uvma_{{ name }}_macros.svh"

// Interface(s)
`include "uvma_{{ name }}_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or monitoring {{ full_name }}.
 */
package uvma_{{ name }}_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_mem_pkg ::*;

   // Constants / Structs / Enums
   `include "uvma_{{ name }}_tdefs.sv"
   `include "uvma_{{ name }}_constants.sv"

   // Objects
   `include "uvma_{{ name }}_cfg.sv"
   `include "uvma_{{ name }}_cntxt.sv"

   // Transactions
   `include "uvma_{{ name }}_mon_trn.sv"
   `include "uvma_{{ name }}_mstr_a_mon_trn.sv"
   `include "uvma_{{ name }}_mstr_r_mon_trn.sv"
   `include "uvma_{{ name }}_slv_a_mon_trn.sv"
   `include "uvma_{{ name }}_slv_r_mon_trn.sv"
   `include "uvma_{{ name }}_seq_item.sv"
   `include "uvma_{{ name }}_mstr_a_seq_item.sv"
   `include "uvma_{{ name }}_mstr_r_seq_item.sv"
   `include "uvma_{{ name }}_slv_a_seq_item.sv"
   `include "uvma_{{ name }}_slv_r_seq_item.sv"

   // Driver
   `include "uvma_{{ name }}_mstr_a_drv.sv"
   `include "uvma_{{ name }}_mstr_r_drv.sv"
   `include "uvma_{{ name }}_slv_a_drv.sv"
   `include "uvma_{{ name }}_slv_r_drv.sv"

   // Virtual Sequencer
   `include "uvma_{{ name }}_mstr_a_sqr.sv"
   `include "uvma_{{ name }}_mstr_r_sqr.sv"
   `include "uvma_{{ name }}_slv_a_sqr.sv"
   `include "uvma_{{ name }}_slv_r_sqr.sv"

   // Agent-Level Components
   `include "uvma_{{ name }}_mon.sv"
   `include "uvma_{{ name }}_drv.sv"
   `include "uvma_{{ name }}_vsqr.sv"
   `include "uvma_{{ name }}_logger.sv"
   `include "uvma_{{ name }}_cov_model.sv"
   `include "uvma_{{ name }}_agent.sv"

   // Sequences
   `include "uvma_{{ name }}_base_vseq.sv"
   `include "uvma_{{ name }}_mon_vseq.sv"
   `include "uvma_{{ name }}_mstr_drv_vseq.sv"
   `include "uvma_{{ name }}_slv_drv_vseq.sv"
   `include "uvma_{{ name }}_idle_vseq.sv"
   `include "uvma_{{ name }}_vseq_lib.sv"
   `include "uvma_{{ name }}_slv_handler_vseq_lib.sv"

   // Register-related
   `include "uvma_{{ name }}_reg_adapter.sv"

endpackage : uvma_{{ name }}_pkg


// Module(s) / Checker(s)
`ifdef UVMA_{{ upper(name) }}_INC_CHKR
`include "uvma_{{ name }}_chkr.sv"
`endif


`endif // __UVMA_{{ upper(name) }}_PKG_SV__

// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_PKG_SV__
`define __UVMA_OBI_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_mem_macros.svh"
`include "uvma_obi_macros.svh"

// Interface(s)
`include "uvma_obi_if.sv"


/**
 * Encapsulates all the types needed for an UVM agent capable of driving and/or monitoring Open Bus Interface.
 */
package uvma_obi_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_mem_pkg ::*;

   // Constants / Structs / Enums
   `include "uvma_obi_tdefs.sv"
   `include "uvma_obi_constants.sv"

   // Objects
   `include "uvma_obi_cfg.sv"
   `include "uvma_obi_cntxt.sv"

   // Transactions
   `include "uvma_obi_mon_trn.sv"
   `include "uvma_obi_mstr_a_mon_trn.sv"
   `include "uvma_obi_mstr_r_mon_trn.sv"
   `include "uvma_obi_slv_a_mon_trn.sv"
   `include "uvma_obi_slv_r_mon_trn.sv"
   `include "uvma_obi_seq_item.sv"
   `include "uvma_obi_mstr_a_seq_item.sv"
   `include "uvma_obi_mstr_r_seq_item.sv"
   `include "uvma_obi_slv_a_seq_item.sv"
   `include "uvma_obi_slv_r_seq_item.sv"

   // Driver
   `include "uvma_obi_mstr_a_drv.sv"
   `include "uvma_obi_mstr_r_drv.sv"
   `include "uvma_obi_slv_a_drv.sv"
   `include "uvma_obi_slv_r_drv.sv"

   // Virtual Sequencer
   `include "uvma_obi_mstr_a_sqr.sv"
   `include "uvma_obi_mstr_r_sqr.sv"
   `include "uvma_obi_slv_a_sqr.sv"
   `include "uvma_obi_slv_r_sqr.sv"

   // Agent-Level Components
   `include "uvma_obi_mon.sv"
   `include "uvma_obi_drv.sv"
   `include "uvma_obi_vsqr.sv"
   `include "uvma_obi_logger.sv"
   `include "uvma_obi_cov_model.sv"
   `include "uvma_obi_agent.sv"

   // Sequences
   `include "uvma_obi_base_vseq.sv"
   `include "uvma_obi_mon_vseq.sv"
   `include "uvma_obi_mstr_drv_vseq.sv"
   `include "uvma_obi_slv_drv_vseq.sv"
   `include "uvma_obi_idle_vseq.sv"
   `include "uvma_obi_vseq_lib.sv"
   `include "uvma_obi_slv_handler_vseq_lib.sv"

   // Register-related
   `include "uvma_obi_reg_adapter.sv"

endpackage : uvma_obi_pkg


// Module(s) / Checker(s)
`ifdef UVMA_OBI_INC_CHKR
`include "uvma_obi_chkr.sv"
`endif


`endif // __UVMA_OBI_PKG_SV__

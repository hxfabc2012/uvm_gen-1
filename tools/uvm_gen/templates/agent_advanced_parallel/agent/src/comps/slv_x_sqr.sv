// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_SLV_A_SQR_SV__
`define __UVMA_OBI_SLV_A_SQR_SV__


/**
 * Component running Open Bus Interface sequences extending uvma_obi_vseq_base_c.
 */
class uvma_obi_slv_a_sqr_c extends uvm_sequencer#(
   .REQ(uvma_obi_slv_a_seq_item_c),
   .RSP(uvma_obi_slv_a_seq_item_c)
);
   
   // Objects
   uvma_obi_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_obi_cntxt_c  cntxt; ///< Agent context handle
   
   
   `uvm_component_utils_begin(uvma_obi_slv_a_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_obi_slv_a_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvma_obi_slv_a_sqr_c


function uvma_obi_slv_a_sqr_c::new(string name="uvma_obi_slv_a_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_obi_slv_a_sqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_obi_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_obi_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`endif // __UVMA_OBI_SLV_A_SQR_SV__

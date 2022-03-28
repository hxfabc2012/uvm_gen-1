// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_COV_MODEL_SV__
`define __UVMA_${name_uppercase}_COV_MODEL_SV__


/**
 * Component encapsulating abstract ${name_normal_case} functional coverage model.
 * Sub-classes must extend this class, add covergroups of their own and override the sample_x() functions.
 */
class uvma_${name}_cov_model_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_${name}_cfg_c       cfg     ; ///< Agent configuration handle
   uvma_${name}_cntxt_c     cntxt   ; ///< Agent context handle
   uvma_${name}_seq_item_c  seq_item; ///< Sequence item currently being sampled
   uvma_${name}_mon_trn_c   mon_trn ; ///< Monitored transaction being sampled
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_${name}_seq_item_c)  seq_item_fifo  ; ///< Queue of sequence items waiting to be sampled.
   uvm_tlm_analysis_fifo #(uvma_${name}_mon_trn_c )  mon_trn_fifo   ; ///< Queue of monitored transactions waiting to be sampled.
   uvm_analysis_export   #(uvma_${name}_seq_item_c)  seq_item_export; ///< Port receiving sequence items.
   uvm_analysis_export   #(uvma_${name}_mon_trn_c )  mon_trn_export ; ///< Port receiving monitored transactions.
   /// @}


   `uvm_component_utils_begin(uvma_${name}_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_cov_model", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Builds fifos.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to fifos.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Forks all sampling loops
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Pure virtual function
    */
   extern virtual function void sample_cfg();

   /**
    * Pure virtual function
    */
   extern virtual function void sample_cntxt();

   /**
    * Pure virtual function
    */
   extern virtual function void sample_seq_item();

   /**
    * Pure virtual function
    */
   extern virtual function void sample_mon_trn();

endclass : uvma_${name}_cov_model_c


function uvma_${name}_cov_model_c::new(string name="uvma_${name}_cov_model", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_${name}_cov_model_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppecase}_COV_MODEL", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppecase}_COV_MODEL", "Context handle is null")
   end

   mon_trn_fifo  = new("mon_trn_fifo" , this);
   seq_item_fifo = new("seq_item_fifo", this);

endfunction : build_phase


task uvma_${name}_cov_model_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   if (cfg.enabled && cfg.cov_model_enabled) begin
      fork
         // Configuration
         forever begin
            cntxt.sample_cfg_e.wait_trigger();
            sample_cfg();
         end

         // Context
         forever begin
            cntxt.sample_cntxt_e.wait_trigger();
            sample_cntxt();
         end

         // Sequence items
         forever begin
            seq_item_fifo.get(seq_item);
            sample_seq_item();
         end

         // Monitor transactions
         forever begin
            mon_trn_fifo.get(mon_trn);
            sample_mon_trn();
         end
      join_none
   end

endtask : run_phase


function void uvma_${name}_cov_model_c::sample_cfg();
   // Implementation left to sub-classes
endfunction : sample_cfg


function void uvma_${name}_cov_model_c::sample_cntxt();
   // Implementation left to sub-classes
endfunction : sample_cntxt


function void uvma_${name}_cov_model_c::sample_seq_item();
   // Implementation left to sub-classes
endfunction : sample_seq_item


function void uvma_${name}_cov_model_c::sample_mon_trn();
   // Implementation left to sub-classes
endfunction : sample_mon_trn


`endif // __UVMA_${name_uppercase}_COV_MODEL_SV__

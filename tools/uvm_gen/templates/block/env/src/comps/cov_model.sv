// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_COV_MODEL_SV__
`define __UVME_${name_uppercase}_COV_MODEL_SV__


/**
 * Component encapsulating ${name_normal_case} Sub-Sytem's functional coverage model.
 */
class uvme_${name}_cov_model_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c             cfg       ; ///< Environment configuration handle
   uvme_${name}_cntxt_c           cntxt     ; ///< Environment context handle
   uvma_${name}_cp_mon_trn_c      cp_trn    ; ///< Control plane transaction being sampled
   uvma_${name}_dp_in_mon_trn_c   dp_in_trn ; ///< Data plane input transaction being sampled
   uvma_${name}_dp_out_mon_trn_c  dp_out_trn; ///< Data plane output transaction being sampled
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_${name}_cp_mon_trn_c    )  cp_fifo      ; ///< Queue of control plane transactions
   uvm_tlm_analysis_fifo #(uvma_${name}_dp_in_mon_trn_c )  dp_in_fifo   ; ///< Queue of data plane input transactions
   uvm_tlm_analysis_fifo #(uvma_${name}_dp_out_mon_trn_c)  dp_out_fifo  ; ///< Queue of data plane outut transactions
   uvm_analysis_port     #(uvma_${name}_cp_mon_trn_c    )  cp_export    ; ///< Port taking in control plane transactions
   uvm_analysis_port     #(uvma_${name}_dp_in_mon_trn_c )  dp_in_export ; ///< Port taking in control plane transactions
   uvm_analysis_port     #(uvma_${name}_dp_out_mon_trn_c)  dp_out_export; ///< Port taking in control plane transactions
   /// @}


   `uvm_component_utils_begin(uvme_${name}_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Coverage for #cfg
    */
   covergroup ${name}_cfg_cg;
      // TODO Implement ${name}_cfg_cg
      //      Ex: abc_cp : coverpoint cfg.abc;
   endgroup : ${name}_cfg_cg

   /**
    * Coverage for #cntxt
    */
   covergroup ${name}_cntxt_cg;
      // TODO Implement ${name}_cntxt_cg
      //      Ex: abc_cp : coverpoint cntxt.abc;
   endgroup : ${name}_cntxt_cg

   /**
    * Coverage for control plane transactions
    */
   covergroup ${name}_cp_trn_cg;
      // TODO Implement ${name}_cp_trn_cg
      //      Ex: abc_cp : coverpoint cp_trn.abc;
   endgroup : ${name}_cp_trn_cg

   /**
    * Coverage for data plane input transactions
    */
   covergroup ${name}_dp_in_trn_cg;
      // TODO Implement ${name}_dp_in_trn_cg
      //      Ex: abc_cp : coverpoint dp_in_trn.abc;
   endgroup : ${name}_dp_in_trn_cg

   /**
    * Coverage for data plane output transactions
    */
   covergroup ${name}_dp_out_trn_cg;
      // TODO Implement ${name}_dp_out_trn_cg
      //      Ex: abc_cp : coverpoint dp_out_trn.abc;
   endgroup : ${name}_dp_out_trn_cg


   /**
    * Creates covergroups.
    */
   extern function new(string name="uvme_${name}_cov_model", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Creates fifos.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to fifos.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Forks all sampling loops.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Samples #${name}_cfg_cg
    */
   extern function void sample_cfg();

   /**
    * Samples #${name}_cntxt_cg
    */
   extern function void sample_cntxt();

   /**
    * Samples #${name}_cp_trn_cg
    */
   extern function void sample_cp_trn();

   /**
    * Samples #${name}_dp_in_trn_cg
    */
   extern function void sample_dp_in_trn();

   /**
    * Samples #${name}_dp_out_trn_cg
    */
   extern function void sample_dp_out_trn();

endclass : uvme_${name}_cov_model_c


function uvme_${name}_cov_model_c::new(string name="uvme_${name}_cov_model", uvm_component parent=null);

   super.new(name, parent);

   ${name}_cfg_cg        = new();
   ${name}_cntxt_cg      = new();
   ${name}_cp_trn_cg     = new();
   ${name}_dp_in_trn_cg  = new();
   ${name}_dp_out_trn_cg = new();

endfunction : new


function void uvme_${name}_cov_model_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_COV_MODEL", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_COV_MODEL", "Context handle is null")
   end

   cp_fifo     = new("cp_fifo"    , this);
   dp_in_fifo  = new("dp_in_fifo" , this);
   dp_out_fifo = new("dp_out_fifo", this);

endfunction : build_phase


function void uvme_${name}_cov_model_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   cp_export     = cp_fifo    .analysis_export;
   dp_in_export  = dp_in_fifo .analysis_export;
   dp_out_export = dp_out_fifo.analysis_export;

endfunction : connect_phase


task uvme_${name}_cov_model_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

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

      // Control plane
      forever begin
         cp_fifo.get(cp_trn);
         sample_cp_trn();
      end

      // Data plane input
      forever begin
         dp_in_fifo.get(dp_in_trn);
         sample_dp_in_trn();
      end

      // Data plane output
      forever begin
         dp_out_fifo.get(dp_out_trn);
         sample_dp_out_trn();
      end
   join_none

endtask : run_phase


function void uvme_${name}_cov_model_c::sample_cfg();

   ${name}_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_${name}_cov_model_c::sample_cntxt();

   ${name}_cntxt_cg.sample();

endfunction : sample_cntxt


function void uvme_${name}_cov_model_c::sample_cp_trn();

   ${name}_cp_trn_cg.sample();

endfunction : sample_cp_trn


function void uvme_${name}_cov_model_c::sample_dp_in_trn();

   ${name}_dp_in_trn_cg.sample();

endfunction : sample_dp_in_trn


function void uvme_${name}_cov_model_c::sample_dp_out_trn();

   ${name}_dp_out_trn_cg.sample();

endfunction : sample_dp_out_trn


`endif // __UVME_${name_uppercase}_COV_MODEL_SV__

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
   uvme_${name}_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c  cntxt; ///< Environment context handle
   // TODO Add covergoup sampling variable(s)
   //      Ex: uvma_pkt_mon_trn_c  pkt_trn; ///< Describe me!
   /// @}

   /// @defgroup TLM
   /// @{
   // TODO Add Input TLM to uvme_${name}_cov_model_c
   //      Ex: uvm_tlm_analysis_fifo #(uvma_pkt_mon_trn_c)  pkt_fifo  ; ///< Describe me!
   //          uvm_analysis_port     #(uvma_pkt_mon_trn_c)  pkt_export; ///< Describe me!
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

   // TODO Add covergroup(s) to uvme_${name}_cov_model_c
   //      Ex: covergroup ${name}_pkt_trn_cg;
   //             address_cp : coverpoint pkt_trn.payload_size {
   //                bins small  = {0   ,   64};
   //                bins medium = {65  , 1024};
   //                bins large  = {1024, 2048};
   //             }
   //          endgroup : ${name}_pkt_trn_cg


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

   // TODO Add coverage functions to uvme_${name}_cov_model_c
   //      Ex: /**
   //           * Samples #${name}_pkt_cg
   //           */
   //          extern function void sample_pkt();

endclass : uvme_${name}_cov_model_c


function uvme_${name}_cov_model_c::new(string name="uvme_${name}_cov_model", uvm_component parent=null);

   super.new(name, parent);

   ${name}_cfg_cg   = new();
   ${name}_cntxt_cg = new();
   // TODO Create coverage groups for uvme_${name}_cov_model_c
   //      Ex: ${name}_pkt_cg = new();

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

   // TODO Build Input TLM
   //      Ex: pkt_fifo = new("pkt_fifo", this);

endfunction : build_phase


function void uvme_${name}_cov_model_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // TODO Connect Input TLM
   //      Ex: pkt_export = pkt_trn_fifo.analysis_export;

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

      // TODO Implement uvme_${name}_cov_model_c::run_phase()
      //      Ex: forever begin
      //             pkt_fifo.get(pkt_trn);
      //             sample_pkt();
      //          end
   join_none

endtask : run_phase


function void uvme_${name}_cov_model_c::sample_cfg();

   ${name}_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_${name}_cov_model_c::sample_cntxt();

   ${name}_cntxt_cg.sample();

endfunction : sample_cntxt


// TODO Implement coverage function(s) to uvme_${name}_cov_model_c
//      Ex: function void uvme_${name}_cov_model_c::sample_pkt();
//
//             ${name}_pkt_trn_cg.sample();
//
//          endfunction : sample_pkt


`endif // __UVME_${name_uppercase}_COV_MODEL_SV__

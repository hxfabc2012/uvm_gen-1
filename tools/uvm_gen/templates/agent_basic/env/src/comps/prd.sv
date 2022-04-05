// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_PRD_SV__
`define __UVME_${name_uppercase}_ST_PRD_SV__


/**
 * Component implementing transaction-based prediction for ${name_normal_case} Self-Testing.
 * Predicts how the passive agent will observe stimulus from the active agent.
 */
class uvme_${name}_st_prd_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_${name}_st_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_st_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_${name}_mon_trn_c)  in_fifo  ; ///< Queue of monitor transactions
   uvm_analysis_export   #(uvma_${name}_mon_trn_c)  in_export; ///< Port taking in transactions from monitor
   uvm_analysis_port     #(uvma_${name}_mon_trn_c)  out_ap   ; ///< Port sending transactions to scoreboard
   /// @}


   `uvm_component_utils_begin(uvme_${name}_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_prd", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Creates TLM objects
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects #in_export to #in_fifo.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Takes in transactions from #in_fifo, processes them and sends them out #out_ap.
    */
   extern virtual task run_phase(uvm_phase phase);

endclass : uvme_${name}_st_prd_c


function uvme_${name}_st_prd_c::new(string name="uvme_${name}_st_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_st_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_ST_PRD", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_ST_PRD", "Context handle is null")
   end

   in_export = new("in_export", this);
   in_fifo   = new("in_fifo"  , this);
   out_ap    = new("out_ap"   , this);

endfunction : build_phase


function void uvme_${name}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   in_export.connect(in_fifo.analysis_export);

endfunction: connect_phase


task uvme_${name}_st_prd_c::run_phase(uvm_phase phase);

   uvma_${name}_mon_trn_c  in_trn, out_trn;

   super.run_phase(phase);

   if (cfg.enabled) begin
      forever begin
         // Get next transaction and copy it
         in_fifo.get(in_trn);
         out_trn = uvma_${name}_mon_trn_c::type_id::create("out_trn");
         out_trn.copy(in_trn);

         // Can't expect passive agent to see transactions while in reset
         if (cntxt.passive_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            out_trn.set_may_drop(1);
         end

         // Send transaction to analysis port
         out_ap.write(out_trn);
      end
   end

endtask: run_phase


`endif // __UVME_${name_uppercase}_ST_PRD_SV__

// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_PRD_SV__
`define __UVME_${name_uppercase}_PRD_SV__


/**
 * Component implementing transaction-based model of ${name_normal_case} Block.
 */
class uvme_${name}_prd_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_clk_mon_trn_c  )  clk_fifo    ; ///< Queue of clk monitor transactions
   uvm_analysis_export   #(uvma_clk_mon_trn_c  )  clk_export  ; ///< Port taking in clk monitor transactions
   uvm_tlm_analysis_fifo #(uvma_reset_mon_trn_c)  reset_fifo  ; ///< Queue of reset monitor transactions
   uvm_analysis_export   #(uvma_reset_mon_trn_c)  reset_export; ///< Port taking in reset monitor transactions
   uvm_tlm_analysis_fifo #(uvma_${name}_cp_mon_trn_c    )  cp_fifo     ; ///< Queue of control plane monitor transactions
   uvm_analysis_export   #(uvma_${name}_cp_mon_trn_c    )  cp_export   ; ///< Port taking in control plane monitor transactions
   uvm_tlm_analysis_fifo #(uvma_${name}_dp_in_mon_trn_c )  dp_in_fifo  ; ///< Queue of data plane input monitor transactions
   uvm_analysis_export   #(uvma_${name}_dp_in_mon_trn_c )  dp_in_export; ///< Port taking in data plane input monitor transactions
   uvm_analysis_port     #(uvma_${name}_dp_out_mon_trn_c)  dp_out_ap   ; ///< Port producing predicted data plane output transactions
   /// @}


   `uvm_component_utils_begin(uvme_${name}_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_prd", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Creates TLM objects
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects exports to fifos.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Takes in transactions from fifos and processes them.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Processes input clk monitor transactions.
    */
   extern task process_clk();

   /**
    * Processes input reset monitor transactions.
    */
   extern task process_reset();

   /**
    * Processes input control plane monitor transactions.
    */
   extern task process_cp();

   /**
    * Processes input data plane input monitor transactions.
    */
   extern task process_dp_in();

endclass : uvme_${name}_prd_c


function uvme_${name}_prd_c::new(string name="uvme_${name}_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_PRD", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_PRD", "Context handle is null")
   end

   // Create TLM objects
   clk_fifo     = new("clk_fifo"    , this);
   clk_export   = new("clk_export"  , this);
   reset_fifo   = new("reset_fifo"  , this);
   reset_export = new("reset_export", this);
   cp_fifo      = new("cp_fifo"     , this);
   cp_export    = new("cp_export"   , this);
   dp_in_fifo   = new("dp_in_fifo"  , this);
   dp_in_export = new("dp_in_export", this);
   dp_out_ap    = new("dp_out_ap"   , this);

endfunction : build_phase


function void uvme_${name}_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // Connect TLM objects
   clk_export  .connect(clk_fifo  .analysis_export);
   reset_export.connect(reset_fifo.analysis_export);
   cp_export   .connect(cp_fifo   .analysis_export);
   dp_in_export.connect(dp_in_fifo.analysis_export);

endfunction: connect_phase


task uvme_${name}_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   fork
      process_clk  ();
      process_reset();
      process_cp   ();
      process_dp_in();
   join_none

endtask: run_phase


task uvme_${name}_prd_c::process_clk();

   uvma_clk_mon_trn_c  clk_trn;

   forever begin
      clk_fifo.get(clk_trn);
      // TODO Implement uvme_${name}_prd_c::process_clk()
   end

endtask : process_clk


task uvme_${name}_prd_c::process_reset();

   uvma_reset_mon_trn_c  reset_trn;

   forever begin
      reset_fifo.get(reset_trn);
      case (reset_trn.transition)
         UVML_EDGE_ASSERTED: begin
            cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
            cntxt.reset();
         end
         UVML_EDGE_DEASSERTED: begin
            cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
         end
      endcase
   end

endtask : process_reset


task uvme_${name}_prd_c::process_cp();

   uvma_${name}_cp_mon_trn_c  cp_trn;

   forever begin
      cp_fifo.get(cp_trn);
      // TODO Implement uvme_${name}_prd_c::process_cp()
   end

endtask : process_cp


task uvme_${name}_prd_c::process_dp_in();

   uvma_${name}_dp_in_mon_trn_c   dp_in_trn ;
   uvma_${name}_dp_out_mon_trn_c  dp_out_trn;

   forever begin
      dp_in_fifo.get(dp_in_trn);
      if (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
         dp_out_trn = uvma_${name}_dp_out_mon_trn_c::type_id::create("dp_out_trn");
         // TODO Implement uvme_${name}_prd_c::process_cp()
         //      Ex: dp_out_trn.abc = dp_in_trn.xyz;
         dp_out_ap.write(dp_out_trn);
      end
   end

endtask : process_dp_in


`endif // __UVME_${name_uppercase}_PRD_SV__

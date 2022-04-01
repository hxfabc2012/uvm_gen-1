// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_PRD_SV__
`define __UVME_${name_uppercase}_PRD_SV__


/**
 * Component implementing transaction-based model of ${name_normal_case} Sub-System.
 */
class uvme_${name}_prd_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup Input TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_clk_mon_trn_c)  ${clk_agent_name}_fifo  ; ///< Queue of ${clk_agent_name} monitor transactions
   uvm_analysis_export   #(uvma_clk_mon_trn_c)  ${clk_agent_name}_export; ///< Port taking in ${clk_agent_name} monitor transactions
   uvm_tlm_analysis_fifo #(uvma_reset_mon_trn_c)  ${reset_agent_name}_fifo  ; ///< Queue of ${reset_agent_name} monitor transactions
   uvm_analysis_export   #(uvma_reset_mon_trn_c)  ${reset_agent_name}_export; ///< Port taking in ${reset_agent_name} monitor transactions
   uvm_tlm_analysis_fifo #(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_name}_fifo  ; ///< Queue of ${ral_agent_type} monitor transactions
   uvm_analysis_export   #(uvma_${ral_agent_type}_mon_trn_c)  ${ral_agent_name}_export; ///< Port taking in ${ral_agent_type} monitor transactions
   /// @}

   /// @defgroup Output TLM
   /// @{
   // TODO Add TLM outputs to uvme_${name}_prd_c
   //      Ex: uvm_analysis_port #(uvma_pkt_trn_c)  pkt_out_ap; ///< Describe me!
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
    * Processes input ${clk_agent_name} monitor transactions.
    */
   extern task process_${clk_agent_name}();

   /**
    * Processes input ${reset_agent_name} monitor transactions.
    */
   extern task process_${reset_agent_name}();

   /**
    * Processes input ${ral_agent_name} monitor transactions.
    */
   extern task process_${ral_agent_name}();

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

   // Build Input TLM objects
   ${clk_agent_name}_fifo   = new("${clk_agent_name}_fifo"  , this);
   ${clk_agent_name}_export = new("${clk_agent_name}_export", this);
   ${reset_agent_name}_fifo   = new("${reset_agent_name}_fifo"  , this);
   ${reset_agent_name}_export = new("${reset_agent_name}_export", this);
   ${ral_agent_name}_fifo   = new("${ral_agent_name}_fifo"  , this);
   ${ral_agent_name}_export = new("${ral_agent_name}_export", this);

   // Build Output TLM objects
   // TODO Create Output TLM objects for uvme_${name}_prd_c
   //      Ex: pkt_out_ap = new("pkt_out_ap", this);

endfunction : build_phase


function void uvme_${name}_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // Connect TLM objects
   ${clk_agent_name}_export.connect(${clk_agent_name}_fifo.analysis_export);
   ${reset_agent_name}_export.connect(${reset_agent_name}_fifo.analysis_export);
   ${ral_agent_name}_export.connect(${ral_agent_name}_fifo.analysis_export);

endfunction: connect_phase


task uvme_${name}_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   fork
      process_${clk_agent_name}();
      process_${reset_agent_name}();
      process_${ral_agent_name}();
   join_none

endtask: run_phase


task uvme_${name}_prd_c::process_${clk_agent_name}();

   uvma_clk_mon_trn_c  ${clk_agent_name}_trn;

   forever begin
      ${clk_agent_name}_fifo.get(${clk_agent_name}_trn);
      // TODO Implement uvme_${name}_prd_c::process_${clk_agent_name}()
   end

endtask : process_${clk_agent_name}


task uvme_${name}_prd_c::process_${reset_agent_name}();

   uvma_reset_mon_trn_c  ${reset_agent_name}_trn;

   forever begin
      ${reset_agent_name}_fifo.get(${reset_agent_name}_trn);
      // TODO Implement uvme_${name}_prd_c::process_${reset_agent_name}()
   end

endtask : process_${reset_agent_name}


task uvme_${name}_prd_c::process_${ral_agent_name}();

   uvma_${ral_agent_type}_mon_trn_c  ${ral_agent_type}_trn;

   forever begin
      ${ral_agent_name}_fifo.get(${ral_agent_type}_trn);
      // TODO Implement uvme_${name}_prd_c::process_${ral_agent_type}()
   end

endtask : process_${ral_agent_name}


`endif // __UVME_${name_uppercase}_PRD_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_PRD_SV__
`define __UVME_{{ upper(name) }}_ST_PRD_SV__


/**
 * Component implementing transaction-based software model of {{ full_name }} Self-Testing DUT.
 */
class uvme_{{ name }}_st_prd_c extends uvm_component;

   // Objects
   uvme_{{ name }}_st_cfg_c    cfg  ; ///<
   uvme_{{ name }}_st_cntxt_c  cntxt; ///<

   // TLM
   uvm_analysis_export  #(uvma_{{ name }}_mon_trn_c)  tx_in_export; ///<
   uvm_analysis_export  #(uvma_{{ name }}_mon_trn_c)  rx_in_export; ///<
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c)  tx_in_fifo  ; ///<
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c)  rx_in_fifo  ; ///<
   uvm_analysis_port    #(uvma_{{ name }}_mon_trn_c)  tx_out_ap   ; ///<
   uvm_analysis_port    #(uvma_{{ name }}_mon_trn_c)  rx_out_ap   ; ///<


   `uvm_component_utils_begin(uvme_{{ name }}_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_prd", uvm_component parent=null);

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::process_tx()
    */
   extern virtual task process_tx();

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::process_rx()
    */
   extern virtual task process_rx();

endclass : uvme_{{ name }}_st_prd_c


function uvme_{{ name }}_st_prd_c::new(string name="uvme_{{ name }}_st_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end

   // Build TLM objects
   tx_in_export  = new("tx_in_export", this);
   rx_in_export  = new("rx_in_export", this);
   tx_in_fifo    = new("tx_in_fifo"  , this);
   rx_in_fifo    = new("rx_in_fifo"  , this);
   tx_out_ap     = new("tx_out_ap"   , this);
   rx_out_ap     = new("rx_out_ap"   , this);

endfunction : build_phase


function void uvme_{{ name }}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // Connect TLM objects
   tx_in_export.connect(tx_in_fifo.analysis_export);
   rx_in_export.connect(rx_in_fifo.analysis_export);

endfunction: connect_phase


task uvme_{{ name }}_st_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   fork
      process_tx();
      process_rx();
   join_none

endtask: run_phase


task uvme_{{ name }}_st_prd_c::process_tx();

   uvma_{{ name }}_mon_trn_c  tx_in_trn, tx_out_trn;

   forever begin
      // Get next transaction and copy it
      tx_in_fifo.get(tx_in_trn);
      tx_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("tx_out_trn");
      tx_out_trn.copy(tx_in_trn);
      tx_out_trn.set_initiator(this);

      if (cntxt.{{ mode_1 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         tx_out_trn.set_may_drop(1);
      end
      if (tx_out_trn.is_idle()) begin
         tx_out_trn.set_may_drop(1);
      end

      // Send transaction to analysis port
      tx_out_ap.write(tx_out_trn);
   end

endfunction: process_tx


task uvme_{{ name }}_st_prd_c::process_rx();

   uvma_{{ name }}_mon_trn_c  rx_in_trn, rx_out_trn;

   forever begin
      // Get next transaction and copy it
      rx_in_fifo.get(rx_in_trn);
      rx_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("rx_out_trn");
      rx_out_trn.copy(rx_in_trn);
      rx_out_trn.set_initiator(this);

      if (cntxt.{{ mode_2 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         rx_out_trn.set_may_drop(1);
      end
      if (rx_out_trn.is_idle()) begin
         rx_out_trn.set_may_drop(1);
      end

      rx_out_ap.write(rx_out_trn);
   end

endfunction: process_rx


`endif // __UVME_{{ upper(name) }}_ST_PRD_SV__

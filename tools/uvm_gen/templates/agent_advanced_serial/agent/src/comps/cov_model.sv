// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_COV_MODEL_SV__
`define __UVMA_{{ upper(name) }}_COV_MODEL_SV__


/**
 * Component encapsulating {{ full_name }} functional coverage model.
 */
class uvma_{{ name }}_cov_model_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c       cfg  ; ///<
   uvma_{{ name }}_cntxt_c     cntxt; ///<
   /// @}

   /// @defgroup Covergroup variables
   /// @{
   uvma_{{ name }}_seq_item_c     seq_item    ; ///<
   uvma_{{ name }}_mon_trn_c      tx_mon_trn  ; ///<
   uvma_{{ name }}_mon_trn_c      rx_mon_trn  ; ///<
{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  tx_phy_seq_item ; ///<
   uvma_{{ name }}_phy_seq_item_c  rx_phy_seq_item ; ///<
   uvma_{{ name }}_phy_mon_trn_c   tx_phy_mon_trn  ; ///<
   uvma_{{ name }}_phy_mon_trn_c   rx_phy_mon_trn  ; ///<
{% else %}   uvma_{{ name }}_tx_seq_item_c  tx_phy_seq_item ; ///<
   uvma_{{ name }}_rx_seq_item_c  rx_phy_seq_item ; ///<
   uvma_{{ name }}_tx_mon_trn_c   tx_phy_mon_trn  ; ///<
   uvma_{{ name }}_rx_mon_trn_c   rx_phy_mon_trn  ; ///<
{% endif %}   /// @}

   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_seq_item_c   )  seq_item_fifo    ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c    )  tx_mon_trn_fifo  ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c    )  rx_mon_trn_fifo  ; ///<
{% if symmetric %}   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_seq_item_c)  tx_phy_seq_item_fifo ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_seq_item_c)  rx_phy_seq_item_fifo ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_mon_trn_c )  tx_phy_mon_trn_fifo  ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_mon_trn_c )  rx_phy_mon_trn_fifo  ; ///<
{% else %}   uvm_tlm_analysis_fifo #(uvma_{{ name }}_tx_seq_item_c)  tx_phy_seq_item_fifo ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_rx_seq_item_c)  rx_phy_seq_item_fifo ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_tx_mon_trn_c )  tx_phy_mon_trn_fifo  ; ///<
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_rx_mon_trn_c )  rx_phy_mon_trn_fifo  ; ///<
{% endif %}   /// @}


   `uvm_component_utils_begin(uvma_{{ name }}_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_cov_model", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds fifos.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Forks all sampling loops
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_tx_mon_trn()
    */
   extern virtual function void sample_tx_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_rx_mon_trn()
    */
   extern virtual function void sample_rx_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_tx_phy_seq_item()
    */
   extern virtual function void sample_tx_phy_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_rx_phy_seq_item()
    */
   extern virtual function void sample_rx_phy_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_tx_phy_mon_trn()
    */
   extern virtual function void sample_tx_phy_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_rx_phy_mon_trn()
    */
   extern virtual function void sample_rx_phy_mon_trn();

endclass : uvma_{{ name }}_cov_model_c


function uvma_{{ name }}_cov_model_c::new(string name="uvma_{{ name }}_cov_model", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_cov_model_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end

   seq_item_fifo = new("seq_item_fifo", this);
   tx_mon_trn_fifo       = new("tx_mon_trn_fifo"     , this);
   rx_mon_trn_fifo       = new("rx_mon_trn_fifo"     , this);
   tx_phy_seq_item_fifo  = new("tx_phy_seq_item_fifo", this);
   rx_phy_seq_item_fifo  = new("rx_phy_seq_item_fifo", this);
   tx_phy_mon_trn_fifo   = new("tx_phy_mon_trn_fifo" , this);
   rx_phy_mon_trn_fifo   = new("rx_phy_mon_trn_fifo" , this);

endfunction : build_phase


task uvma_{{ name }}_cov_model_c::run_phase(uvm_phase phase);

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

         // Monitor tx transactions
         forever begin
            tx_mon_trn_fifo.get(tx_mon_trn);
            sample_tx_mon_trn();
         end

         // Monitor rx transactions
         forever begin
            rx_mon_trn_fifo.get(rx_mon_trn);
            sample_rx_mon_trn();
         end

         // Sequence tx phy items
         forever begin
            tx_phy_seq_item_fifo.get(tx_phy_seq_item);
            sample_tx_phy_seq_item();
         end

         // Sequence rx phy items
         forever begin
            rx_phy_seq_item_fifo.get(rx_phy_seq_item);
            sample_rx_phy_seq_item();
         end

         // Monitor tx phy transactions
         forever begin
            tx_phy_mon_trn_fifo.get(tx_phy_mon_trn);
            sample_tx_phy_mon_trn();
         end

         // Monitor rx phy transactions
         forever begin
            rx_phy_mon_trn_fifo.get(rx_phy_mon_trn);
            sample_rx_phy_mon_trn();
         end
      join_none
   end

endtask : run_phase


function void uvma_{{ name }}_cov_model_c::sample_cfg();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_cfg();

endfunction : sample_cfg


function void uvma_{{ name }}_cov_model_c::sample_cntxt();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_cntxt();

endfunction : sample_cntxt


function void uvma_{{ name }}_cov_model_c::sample_seq_item();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_seq_item();

endfunction : sample_seq_item


function void uvma_{{ name }}_cov_model_c::sample_tx_mon_trn();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_tx_mon_trn();

endfunction : sample_tx_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_rx_mon_trn();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_rx_mon_trn();

endfunction : sample_rx_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_tx_phy_seq_item();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_tx_phy_seq_item();

endfunction : sample_tx_phy_seq_item


function void uvma_{{ name }}_cov_model_c::sample_rx_phy_seq_item();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_rx_phy_seq_item();

endfunction : sample_rx_phy_seq_item


function void uvma_{{ name }}_cov_model_c::sample_tx_phy_mon_trn();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_tx_phy_mon_trn();

endfunction : sample_tx_phy_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_rx_phy_mon_trn();

   // TODO Implement uvma_{{ name }}_cov_model_c::sample_rx_phy_mon_trn();

endfunction : sample_rx_phy_mon_trn


`endif // __UVMA_{{ upper(name) }}_COV_MODEL_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_COV_MODEL_SV__
`define __UVMA_{{ upper(name) }}_COV_MODEL_SV__


/**
 * Component encapsulating {{ full_name }} functional coverage model.
 */
class uvma_{{ name }}_cov_model_c extends uvm_component;
   
   // Objects
   uvma_{{ name }}_cfg_c       cfg  ; ///< 
   uvma_{{ name }}_cntxt_c     cntxt; ///< 
   
   // Covergroup variables
   uvma_{{ name }}_mon_trn_c      mon_trn_tx  ; ///< 
   uvma_{{ name }}_mon_trn_c      mon_trn_rx  ; ///< 
   uvma_{{ name }}_{{ tx }}_mon_trn_c   {{ tx }}_mon_trn  ; ///< 
   uvma_{{ name }}_{{ rx }}_mon_trn_c   {{ rx }}_mon_trn  ; ///< 
   uvma_{{ name }}_seq_item_c     seq_item    ; ///< 
   uvma_{{ name }}_{{ tx }}_seq_item_c  {{ tx }}_seq_item ; ///< 
   uvma_{{ name }}_{{ rx }}_seq_item_c  {{ rx }}_seq_item ; ///< 
   
   // TLM
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ tx }}_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ rx }}_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_mon_trn_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_mon_trn_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_seq_item_c   )  seq_item_fifo    ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_seq_item_fifo ; ///< 
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_seq_item_fifo ; ///< 
   
   
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
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_mon_trn_tx()
    */
   extern virtual function void sample_mon_trn_tx();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_mon_trn_rx()
    */
   extern virtual function void sample_mon_trn_rx();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_{{ tx }}_mon_trn()
    */
   extern virtual function void sample_{{ tx }}_mon_trn();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_{{ rx }}_mon_trn()
    */
   extern virtual function void sample_{{ rx }}_mon_trn();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_{{ tx }}_seq_item()
    */
   extern virtual function void sample_{{ tx }}_seq_item();
   
   /**
    * TODO Describe uvma_{{ name }}_cov_model_c::sample_{{ rx }}_seq_item()
    */
   extern virtual function void sample_{{ rx }}_seq_item();
   
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
   
   mon_trn_{{ tx }}_fifo   = new("mon_trn_{{ tx }}_fifo" , this);
   mon_trn_{{ rx }}_fifo   = new("mon_trn_{{ rx }}_fifo" , this);
   {{ tx }}_mon_trn_fifo   = new("{{ tx }}_mon_trn_fifo" , this);
   {{ rx }}_mon_trn_fifo   = new("{{ rx }}_mon_trn_fifo" , this);
   seq_item_fifo     = new("seq_item_fifo"   , this);
   {{ tx }}_seq_item_fifo  = new("{{ tx }}_seq_item_fifo", this);
   {{ rx }}_seq_item_fifo  = new("{{ rx }}_seq_item_fifo", this);
   
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
         
         // Monitor tx transactions
         forever begin
            mon_trn_{{ tx }}_fifo.get(mon_trn_tx);
            sample_mon_trn_tx();
         end
         
         // Monitor rx transactions
         forever begin
            mon_trn_{{ rx }}_fifo.get(mon_trn_rx);
            sample_mon_trn_rx();
         end
         
         // Monitor tx transactions
         forever begin
            {{ tx }}_mon_trn_fifo.get({{ tx }}_mon_trn);
            sample_{{ tx }}_mon_trn();
         end
         
         // Monitor rx transactions
         forever begin
            {{ rx }}_mon_trn_fifo.get({{ rx }}_mon_trn);
            sample_{{ rx }}_mon_trn();
         end
         
         // Sequence items
         forever begin
            seq_item_fifo.get(seq_item);
            sample_seq_item();
         end
         
         // Sequence tx items
         forever begin
            {{ tx }}_seq_item_fifo.get({{ tx }}_seq_item);
            sample_{{ tx }}_seq_item();
         end
         
         // Sequence rx items
         forever begin
            {{ rx }}_seq_item_fifo.get({{ rx }}_seq_item);
            sample_{{ rx }}_seq_item();
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


function void uvma_{{ name }}_cov_model_c::sample_mon_trn_tx();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_mon_trn_tx();
   
endfunction : sample_mon_trn_tx


function void uvma_{{ name }}_cov_model_c::sample_mon_trn_rx();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_mon_trn_rx();
   
endfunction : sample_mon_trn_rx


function void uvma_{{ name }}_cov_model_c::sample_{{ tx }}_mon_trn();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_{{ tx }}_mon_trn();
   
endfunction : sample_{{ tx }}_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_{{ rx }}_mon_trn();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_{{ rx }}_mon_trn();
   
endfunction : sample_{{ rx }}_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_seq_item();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_seq_item();
   
endfunction : sample_seq_item


function void uvma_{{ name }}_cov_model_c::sample_{{ tx }}_seq_item();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_{{ tx }}_seq_item();
   
endfunction : sample_{{ tx }}_seq_item


function void uvma_{{ name }}_cov_model_c::sample_{{ rx }}_seq_item();
   
   // TODO Implement uvma_{{ name }}_cov_model_c::sample_{{ rx }}_seq_item();
   
endfunction : sample_{{ rx }}_seq_item


`endif // __UVMA_{{ upper(name) }}_COV_MODEL_SV__

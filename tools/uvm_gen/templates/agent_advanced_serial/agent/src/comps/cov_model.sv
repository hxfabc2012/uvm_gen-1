// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_COV_MODEL_SV__
`define __UVMA_{{ name.upper() }}_COV_MODEL_SV__


/**
 * Abstract component providing a base for {{ full_name }} Agent functional coverage models.
 */
class uvma_{{ name }}_cov_model_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c       cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c     cntxt; ///< Agent context handle
   /// @}

   /// @defgroup Covergroup Variables
   /// @{
   uvma_{{ name }}_seq_item_c     seq_item    ; ///< Sequence Item currently being sampled.
   uvma_{{ name }}_mon_trn_c      {{ tx }}_mon_trn  ; ///< {{ tx.upper() }} Monitor Transaction currently being sampled.
   uvma_{{ name }}_mon_trn_c      {{ rx }}_mon_trn  ; ///< {{ rx.upper() }} Monitor Transaction currently being sampled.
{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  {{ tx }}_phy_seq_item ; ///< {{ tx.upper() }} Phy Sequence Item currently being sampled.
   uvma_{{ name }}_phy_seq_item_c  {{ rx }}_phy_seq_item ; ///< {{ rx.upper() }} Phy Sequence Item currently being sampled.
   uvma_{{ name }}_phy_mon_trn_c   {{ tx }}_phy_mon_trn  ; ///< {{ tx.upper() }} Phy Monitor Transaction currently being sampled.
   uvma_{{ name }}_phy_mon_trn_c   {{ rx }}_phy_mon_trn  ; ///< {{ rx.upper() }} Phy Monitor Transaction currently being sampled.
{% else %}   uvma_{{ name }}_{{ tx }}_seq_item_c  {{ tx }}_phy_seq_item ; ///< {{ tx.upper() }} Phy Sequence Item currently being sampled.
   uvma_{{ name }}_{{ rx }}_seq_item_c  {{ rx }}_phy_seq_item ; ///< {{ rx.upper() }} Phy Sequence Item currently being sampled.
   uvma_{{ name }}_{{ tx }}_mon_trn_c   {{ tx }}_phy_mon_trn  ; ///< {{ tx.upper() }} Phy Monitor Transaction currently being sampled.
   uvma_{{ name }}_{{ rx }}_mon_trn_c   {{ rx }}_phy_mon_trn  ; ///< {{ rx.upper() }} Phy Monitor Transaction currently being sampled.
{% endif %}   /// @}

   /// @defgroup TLM FIFOs
   /// @{
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_seq_item_c   )  seq_item_fifo    ; ///< FIFO of Sequence Items to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c    )  {{ tx }}_mon_trn_fifo  ; ///< FIFO of {{ tx.upper() }} Monitor Transactions to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c    )  {{ rx }}_mon_trn_fifo  ; ///< FIFO of {{ rx.upper() }} Monitor Transactions to be sampled.
{% if symmetric %}   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_phy_seq_item_fifo ; ///< FIFO of {{ tx.upper() }} Phy Sequence Items to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_phy_seq_item_fifo ; ///< FIFO of {{ rx.upper() }} Phy Sequence Item to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_mon_trn_c )  {{ tx }}_phy_mon_trn_fifo  ; ///< FIFO of {{ tx.upper() }} Phy Monitor Transactions to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_phy_mon_trn_c )  {{ rx }}_phy_mon_trn_fifo  ; ///< FIFO of {{ rx.upper() }} Phy Monitor Transactions to be sampled.
{% else %}   uvm_tlm_analysis_fifo #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_phy_seq_item_fifo ; ///< FIFO of {{ tx.upper() }} Phy Sequence Items to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_phy_seq_item_fifo ; ///< FIFO of {{ rx.upper() }} Phy Sequence Item to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_phy_mon_trn_fifo  ; ///< FIFO of {{ tx.upper() }} Phy Monitor Transactions to be sampled.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_phy_mon_trn_fifo  ; ///< FIFO of {{ rx.upper() }} Phy Monitor Transactions to be sampled.
{% endif %}   /// @}

   /// @defgroup TLM Exports
   /// @{
   uvm_analysis_export #(uvma_{{ name }}_seq_item_c)  seq_item_export   ; ///< Port for Sequence Items to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_mon_trn_export ; ///< Port for {{ tx.upper() }} Monitor Transactions to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_mon_trn_export ; ///< Port for {{ rx.upper() }} Monitor Transactions to be sampled.
{% if symmetric %}   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_phy_seq_item_export; ///< Port for {{ tx.upper() }} Phy Sequence Items to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_phy_seq_item_export; ///< Port for {{ rx.upper() }} Phy Sequence Items to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  {{ tx }}_phy_mon_trn_export ; ///< Port for {{ tx.upper() }} Phy Monitor Transactions to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  {{ rx }}_phy_mon_trn_export ; ///< Port for {{ rx.upper() }} Phy Monitor Transactions to be sampled.
{% else %}   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_phy_seq_item_export; ///< Port for {{ tx.upper() }} Phy Sequence Items to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_phy_seq_item_export; ///< Port for {{ rx.upper() }} Phy Sequence Items to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_phy_mon_trn_export ; ///< Port for {{ tx.upper() }} Phy Monitor Transactions to be sampled.
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_phy_mon_trn_export ; ///< Port for {{ rx.upper() }} Phy Monitor Transactions to be sampled.
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
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Builds FIFOs.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects TLM Objects.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Forks all sampling loops.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Creates Exports and FIFOs.
    */
   extern function void create_tlm_objects();

   /**
    * Connects Exports to FIFOs.
    */
   extern function void connect_fifos();

   /**
    * User hook for sampling #cfg.
    * Pure virtual.
    */
   extern virtual function void sample_cfg();

   /**
    * User hook for sampling #cntxt.
    * Pure virtual.
    */
   extern virtual function void sample_cntxt();

   /**
    * User hook for sampling #seq_item.
    * Pure virtual.
    */
   extern virtual function void sample_seq_item();

   /**
    * User hook for sampling #{{ tx }}_mon_trn.
    * Pure virtual.
    */
   extern virtual function void sample_{{ tx }}_mon_trn();

   /**
    * User hook for sampling #{{ rx }}_mon_trn.
    * Pure virtual.
    */
   extern virtual function void sample_{{ rx }}_mon_trn();

   /**
    * User hook for sampling #{{ tx }}_phy_seq_item.
    * Pure virtual.
    */
   extern virtual function void sample_{{ tx }}_phy_seq_item();

   /**
    * User hook for sampling #{{ rx }}_phy_seq_item.
    * Pure virtual.
    */
   extern virtual function void sample_{{ rx }}_phy_seq_item();

   /**
    * User hook for sampling #{{ tx }}_phy_mon_trn.
    * Pure virtual.
    */
   extern virtual function void sample_{{ tx }}_phy_mon_trn();

   /**
    * User hook for sampling #{{ rx }}_phy_mon_trn.
    * Pure virtual.
    */
   extern virtual function void sample_{{ rx }}_phy_mon_trn();

endclass : uvma_{{ name }}_cov_model_c


function uvma_{{ name }}_cov_model_c::new(string name="uvma_{{ name }}_cov_model", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_cov_model_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg           ();
   get_cntxt         ();
   create_tlm_objects();

endfunction : build_phase


function void uvma_{{ name }}_cov_model_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_fifos();

endfunction : connect_phase


task uvma_{{ name }}_cov_model_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   if (cfg.enabled && cfg.cov_model_enabled) begin
      fork
         forever begin
            cntxt.sample_cfg_e.wait_trigger();
            sample_cfg();
         end
         forever begin
            cntxt.sample_cntxt_e.wait_trigger();
            sample_cntxt();
         end
         forever begin
            seq_item_fifo.get(seq_item);
            sample_seq_item();
         end
         forever begin
            {{ tx }}_mon_trn_fifo.get({{ tx }}_mon_trn);
            sample_{{ tx }}_mon_trn();
         end
         forever begin
            {{ rx }}_mon_trn_fifo.get({{ rx }}_mon_trn);
            sample_{{ rx }}_mon_trn();
         end
         forever begin
            {{ tx }}_phy_seq_item_fifo.get({{ tx }}_phy_seq_item);
            sample_{{ tx }}_phy_seq_item();
         end
         forever begin
            {{ rx }}_phy_seq_item_fifo.get({{ rx }}_phy_seq_item);
            sample_{{ rx }}_phy_seq_item();
         end
         forever begin
            {{ tx }}_phy_mon_trn_fifo.get({{ tx }}_phy_mon_trn);
            sample_{{ tx }}_phy_mon_trn();
         end
         forever begin
            {{ rx }}_phy_mon_trn_fifo.get({{ rx }}_phy_mon_trn);
            sample_{{ rx }}_phy_mon_trn();
         end
      join_none
   end

endtask : run_phase


function void uvma_{{ name }}_cov_model_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_COV_MODEL", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_cov_model_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_COV_MODEL", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_cov_model_c::create_tlm_objects();

   seq_item_fifo = new("seq_item_fifo", this);
   {{ tx }}_mon_trn_fifo      = new("{{ tx }}_mon_trn_fifo"     , this);
   {{ rx }}_mon_trn_fifo      = new("{{ rx }}_mon_trn_fifo"     , this);
   {{ tx }}_phy_seq_item_fifo = new("{{ tx }}_phy_seq_item_fifo", this);
   {{ rx }}_phy_seq_item_fifo = new("{{ rx }}_phy_seq_item_fifo", this);
   {{ tx }}_phy_mon_trn_fifo  = new("{{ tx }}_phy_mon_trn_fifo" , this);
   {{ rx }}_phy_mon_trn_fifo  = new("{{ rx }}_phy_mon_trn_fifo" , this);

endfunction : create_tlm_objects


function void uvma_{{ name }}_cov_model_c::connect_fifos();

   seq_item_export = seq_item_fifo.analysis_export;
   {{ tx }}_mon_trn_export      = {{ tx }}_mon_trn_fifo     .analysis_export;
   {{ rx }}_mon_trn_export      = {{ rx }}_mon_trn_fifo     .analysis_export;
   {{ tx }}_phy_seq_item_export = {{ tx }}_phy_seq_item_fifo.analysis_export;
   {{ rx }}_phy_seq_item_export = {{ rx }}_phy_seq_item_fifo.analysis_export;
   {{ tx }}_phy_mon_trn_export  = {{ tx }}_phy_mon_trn_fifo .analysis_export;
   {{ rx }}_phy_mon_trn_export  = {{ rx }}_phy_mon_trn_fifo .analysis_export;

endfunction : connect_fifos


function void uvma_{{ name }}_cov_model_c::sample_cfg();
endfunction : sample_cfg


function void uvma_{{ name }}_cov_model_c::sample_cntxt();
endfunction : sample_cntxt


function void uvma_{{ name }}_cov_model_c::sample_seq_item();
endfunction : sample_seq_item


function void uvma_{{ name }}_cov_model_c::sample_{{ tx }}_mon_trn();
endfunction : sample_{{ tx }}_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_{{ rx }}_mon_trn();
endfunction : sample_{{ rx }}_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_{{ tx }}_phy_seq_item();
endfunction : sample_{{ tx }}_phy_seq_item


function void uvma_{{ name }}_cov_model_c::sample_{{ rx }}_phy_seq_item();
endfunction : sample_{{ rx }}_phy_seq_item


function void uvma_{{ name }}_cov_model_c::sample_{{ tx }}_phy_mon_trn();
endfunction : sample_{{ tx }}_phy_mon_trn


function void uvma_{{ name }}_cov_model_c::sample_{{ rx }}_phy_mon_trn();
endfunction : sample_{{ rx }}_phy_mon_trn


`endif // __UVMA_{{ name.upper() }}_COV_MODEL_SV__

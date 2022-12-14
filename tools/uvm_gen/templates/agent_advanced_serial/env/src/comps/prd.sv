// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_PRD_SV__
`define __UVME_{{ name.upper() }}_ST_PRD_SV__


/**
 * Component implementing transaction-based prediction for ${name_normal_case} UVM Agent Self-Testing Environment.
 * Predicts how the Passive Agent will observe stimulus from {{ mode_1.upper() }} & {{ mode_2.upper() }} Agents.
 */
class uvme_{{ name }}_st_prd_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_{{ name }}_st_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_export   #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_in_export; ///< Port for Monitor Transactions from {{ mode_1.upper() }} Agent {{ tx.upper() }}.
   uvm_analysis_export   #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_in_export; ///< Port for Monitor Transactions from {{ mode_2.upper() }} Agent {{ rx.upper() }}.
   uvm_analysis_export   #(uvma_{{ name }}_seq_item_c)  {{ mode_1 }}_in_export; ///< Port for Sequence Items from {{ mode_1.upper() }} Agent {{ tx.upper() }}.
   uvm_analysis_export   #(uvma_{{ name }}_seq_item_c)  {{ mode_2 }}_in_export; ///<  Port for Sequence Items from {{ mode_2.upper() }} Agent {{ rx.upper() }}.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_in_fifo; ///< FIFO of Monitor Transactions from {{ mode_1.upper() }} Agent {{ tx.upper() }}.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_in_fifo; ///< FIFO of Monitor Transactions from {{ mode_2.upper() }} Agent {{ rx.upper() }}.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_seq_item_c)  {{ mode_1 }}_in_fifo; ///< FIFO of Sequence Items from {{ mode_1.upper() }} Agent {{ tx.upper() }}.
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_seq_item_c)  {{ mode_2 }}_in_fifo; ///< FIFO of Sequence Items from {{ mode_2.upper() }} Agent {{ rx.upper() }}.
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_out_ap; ///< Port outputting Monitor Transactions for Scoreboard {{ tx.upper() }} Expected.
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_out_ap; ///< Port outputting Monitor Transactions for Scoreboard {{ rx.upper() }} Expected.
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c )  {{ mode_1 }}_out_ap; ///< Port outputting Monitor Transactions for Scoreboard {{ mode_1.upper() }} Expected.
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c )  {{ mode_2 }}_out_ap; ///< Port outputting Monitor Transactions for Scoreboard {{ mode_2.upper() }} Expected.
   /// @}


   `uvm_component_utils_begin(uvme_{{ name }}_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_prd", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Creates TLM objects
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects Exports to FIFOs.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Forks all processing tasks.
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
    * Creates TLM FIFOs and Analysis Ports.
    */
   extern function void create_tlm_objects();

   /**
    * Connects Exports to FIFOs.
    */
   extern function void connect_ports();

   /**
    * Predicts {{ tx.upper() }} data path.
    */
   extern task process_{{ tx }}();

   /**
    * Predicts {{ rx.upper() }} data path.
    */
   extern task process_{{ rx }}();

   /**
    * Predicts {{ mode_1.upper() }} data path.
    */
   extern task process_{{ mode_1 }}();

   /**
    * Predicts {{ mode_1.upper() }} data path.
    */
   extern task process_{{ mode_2 }}();

endclass : uvme_{{ name }}_st_prd_c


function uvme_{{ name }}_st_prd_c::new(string name="uvme_{{ name }}_st_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg           ();
   get_cntxt         ();
   create_tlm_objects();

endfunction : build_phase


function void uvme_{{ name }}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_ports();

endfunction : connect_phase


task uvme_{{ name }}_st_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   fork
      process_{{ tx }}();
      process_{{ rx }}();
      process_{{ mode_1 }}();
      process_{{ mode_2 }}();
   join_none

endtask : run_phase


function void uvme_{{ name }}_st_prd_c::get_cfg();

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_ST_PRD", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_{{ name }}_st_prd_c::get_cntxt();

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_ST_PRD", "Context handle is null")
   end

endfunction : get_cntxt


function void uvme_{{ name }}_st_prd_c::create_tlm_objects();

   {{ tx }}_in_fifo = new("{{ tx }}_in_fifo", this);
   {{ rx }}_in_fifo = new("{{ rx }}_in_fifo", this);
   {{ mode_1 }}_in_fifo = new("{{ mode_1 }}_in_fifo", this);
   {{ mode_2 }}_in_fifo = new("{{ mode_2 }}_in_fifo", this);
   {{ tx }}_out_ap = new("{{ tx }}_out_ap", this);
   {{ rx }}_out_ap = new("{{ rx }}_out_ap", this);
   {{ mode_1 }}_out_ap = new("{{ mode_1 }}_out_ap", this);
   {{ mode_2 }}_out_ap = new("{{ mode_2 }}_out_ap", this);

endfunction : create_tlm_objects


function void uvme_{{ name }}_st_prd_c::connect_ports();

   {{ tx }}_in_export = {{ tx }}_in_fifo.analysis_export;
   {{ rx }}_in_export = {{ rx }}_in_fifo.analysis_export;
   {{ mode_1 }}_in_export = {{ mode_1 }}_in_fifo.analysis_export;
   {{ mode_2 }}_in_export = {{ mode_2 }}_in_fifo.analysis_export;

endfunction : connect_ports


task uvme_{{ name }}_st_prd_c::process_{{ tx }}();

   uvma_{{ name }}_mon_trn_c  {{ tx }}_in_trn, {{ tx }}_out_trn;
   forever begin
      {{ tx }}_in_fifo.get({{ tx }}_in_trn);
      {{ tx }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ tx }}_out_trn");
      {{ tx }}_out_trn.copy({{ tx }}_in_trn);
      {{ tx }}_out_trn.set_initiator(this);
      if ({{ tx }}_out_trn.header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
         if (cntxt.{{ mode_1 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            {{ tx }}_out_trn.set_may_drop(1);
         end
         if ({{ tx }}_in_trn.has_error()) begin
            {{ tx }}_out_trn.set_may_drop(1);
         end
         {{ tx }}_out_ap.write({{ tx }}_out_trn);
      end
   end

endtask : process_{{ tx }}


task uvme_{{ name }}_st_prd_c::process_{{ rx }}();

   uvma_{{ name }}_mon_trn_c  {{ rx }}_in_trn, {{ rx }}_out_trn;
   forever begin
      {{ rx }}_in_fifo.get({{ rx }}_in_trn);
      {{ rx }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ rx }}_out_trn");
      {{ rx }}_out_trn.copy({{ rx }}_in_trn);
      {{ rx }}_out_trn.set_initiator(this);
      if ({{ rx }}_out_trn.header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
         if (cntxt.{{ mode_2 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            {{ rx }}_out_trn.set_may_drop(1);
         end
         if ({{ rx }}_in_trn.has_error()) begin
            {{ rx }}_out_trn.set_may_drop(1);
         end
         {{ rx }}_out_ap.write({{ rx }}_out_trn);
      end
   end

endtask : process_{{ rx }}


task uvme_{{ name }}_st_prd_c::process_{{ mode_1 }}();

   uvma_{{ name }}_seq_item_c  {{ mode_1 }}_in_trn ;
   uvma_{{ name }}_mon_trn_c   {{ mode_1 }}_out_trn;
   forever begin
      {{ mode_1 }}_in_fifo.get({{ mode_1 }}_in_trn);
      {{ mode_1 }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ mode_1 }}_out_trn");
      {{ mode_1 }}_out_trn.header = {{ mode_1 }}_in_trn.header;
      {{ mode_1 }}_out_trn.data   = {{ mode_1 }}_in_trn.data  ;
      {{ mode_1 }}_out_trn.tail   = {{ mode_1 }}_in_trn.tail  ;
      {{ mode_1 }}_out_trn.set_initiator(this);
      if ({{ mode_1 }}_out_trn.header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
         if (cntxt.passive_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            {{ mode_1 }}_out_trn.set_may_drop(1);
         end
         if ({{ mode_1 }}_in_trn.has_error()) begin
            {{ mode_1 }}_out_trn.set_may_drop(1);
         end
         {{ mode_1 }}_out_ap.write({{ mode_1 }}_out_trn);
      end
   end

endtask : process_{{ mode_1 }}


task uvme_{{ name }}_st_prd_c::process_{{ mode_2 }}();

   uvma_{{ name }}_seq_item_c  {{ mode_2 }}_in_trn ;
   uvma_{{ name }}_mon_trn_c   {{ mode_2 }}_out_trn;
   forever begin
      {{ mode_2 }}_in_fifo.get({{ mode_2 }}_in_trn);
      {{ mode_2 }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ mode_2 }}_out_trn");
      {{ mode_2 }}_out_trn.header = {{ mode_2 }}_in_trn.header;
      {{ mode_2 }}_out_trn.data   = {{ mode_2 }}_in_trn.data  ;
      {{ mode_2 }}_out_trn.tail   = {{ mode_2 }}_in_trn.tail  ;
      {{ mode_2 }}_out_trn.set_initiator(this);
      if ({{ mode_2 }}_out_trn.header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
         if (cntxt.passive_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            {{ mode_2 }}_out_trn.set_may_drop(1);
         end
         if ({{ mode_2 }}_in_trn.has_error()) begin
            {{ mode_2 }}_out_trn.set_may_drop(1);
         end
         {{ mode_2 }}_out_ap.write({{ mode_2 }}_out_trn);
      end
   end

endtask : process_{{ mode_2 }}


`endif // __UVME_{{ name.upper() }}_ST_PRD_SV__

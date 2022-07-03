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
   uvm_analysis_export  #(uvma_{{ name }}_mon_trn_c)  {{ tx }}_in_export; ///<
   uvm_analysis_export  #(uvma_{{ name }}_mon_trn_c)  {{ rx }}_in_export; ///<
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c)  {{ tx }}_in_fifo  ; ///<
   uvm_tlm_analysis_fifo#(uvma_{{ name }}_mon_trn_c)  {{ rx }}_in_fifo  ; ///<
   uvm_analysis_port    #(uvma_{{ name }}_mon_trn_c)  {{ tx }}_out_ap   ; ///<
   uvm_analysis_port    #(uvma_{{ name }}_mon_trn_c)  {{ rx }}_out_ap   ; ///<


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
    * TODO Describe uvme_{{ name }}_st_prd_c::process_{{ tx }}()
    */
   extern virtual task process_{{ tx }}();

   /**
    * TODO Describe uvme_{{ name }}_st_prd_c::process_{{ rx }}()
    */
   extern virtual task process_{{ rx }}();

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
   {{ tx }}_in_export  = new("{{ tx }}_in_export", this);
   {{ rx }}_in_export  = new("{{ rx }}_in_export", this);
   {{ tx }}_in_fifo    = new("{{ tx }}_in_fifo"  , this);
   {{ rx }}_in_fifo    = new("{{ rx }}_in_fifo"  , this);
   {{ tx }}_out_ap     = new("{{ tx }}_out_ap"   , this);
   {{ rx }}_out_ap     = new("{{ rx }}_out_ap"   , this);

endfunction : build_phase


function void uvme_{{ name }}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // Connect TLM objects
   {{ tx }}_in_export.connect({{ tx }}_in_fifo.analysis_export);
   {{ rx }}_in_export.connect({{ rx }}_in_fifo.analysis_export);

endfunction: connect_phase


task uvme_{{ name }}_st_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   fork
      process_{{ tx }}();
      process_{{ rx }}();
   join_none

endtask: run_phase


task uvme_{{ name }}_st_prd_c::process_{{ tx }}();

   uvma_{{ name }}_mon_trn_c  {{ tx }}_in_trn, {{ tx }}_out_trn;

   forever begin
      // Get next transaction and copy it
      {{ tx }}_in_fifo.get({{ tx }}_in_trn);
      {{ tx }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ tx }}_out_trn");
      {{ tx }}_out_trn.copy({{ tx }}_in_trn);
      {{ tx }}_out_trn.set_initiator(this);

      if (cntxt.{{ mode_1 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         {{ tx }}_out_trn.set_may_drop(1);
      end
      if ({{ tx }}_out_trn.is_idle()) begin
         {{ tx }}_out_trn.set_may_drop(1);
      end

      // Send transaction to analysis port
      {{ tx }}_out_ap.write({{ tx }}_out_trn);
   end

endfunction: process_{{ tx }}


task uvme_{{ name }}_st_prd_c::process_{{ rx }}();

   uvma_{{ name }}_mon_trn_c  {{ rx }}_in_trn, {{ rx }}_out_trn;

   forever begin
      // Get next transaction and copy it
      {{ rx }}_in_fifo.get({{ rx }}_in_trn);
      {{ rx }}_out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("{{ rx }}_out_trn");
      {{ rx }}_out_trn.copy({{ rx }}_in_trn);
      {{ rx }}_out_trn.set_initiator(this);

      if (cntxt.{{ mode_2 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         {{ rx }}_out_trn.set_may_drop(1);
      end
      if ({{ rx }}_out_trn.is_idle()) begin
         {{ rx }}_out_trn.set_may_drop(1);
      end

      {{ rx }}_out_ap.write({{ rx }}_out_trn);
   end

endfunction: process_{{ rx }}


`endif // __UVME_{{ upper(name) }}_ST_PRD_SV__

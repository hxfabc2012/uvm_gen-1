// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name_uppercase }}_ST_PRD_SV__
`define __UVME_{{ name_uppercase }}_ST_PRD_SV__


/**
 * Component implementing transaction-based prediction for {{ name_proper }} Self-Testing.
{% if symmetry %} * Predicts how the {{ mode_2 }} agent will observe stimulus from the {{ mode_1 }} agent.
{% else %}{% endif %}
 */
class uvme_{{ name }}_st_prd_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_{{ name }}_st_cntxt_c  cntxt; ///< Environment context handle
   /// @}
{% ifdef full_duplex %}
   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c)  {{ mode_1 }}_in_fifo; ///< Queue of {{ mode_1 }} monitor transactions
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c)  {{ mode_2 }}_in_fifo; ///< Queue of {{ mode_2 }} monitor transactions
   uvm_analysis_export   #(uvma_{{ name }}_mon_trn_c)  {{ mode_1 }}_in_export; ///< Port taking in {{ mode_1 }} transactions from monitor
   uvm_analysis_export   #(uvma_{{ name }}_mon_trn_c)  {{ mode_2 }}_in_export; ///< Port taking in {{ mode_2 }} transactions from monitor
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c)  {{ mode_1 }}_out_ap; ///< Port sending {{ mode_1 }} transactions to scoreboard
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c)  {{ mode_2 }}_out_ap; ///< Port sending {{ mode_2 }} transactions to scoreboard
   /// @}
{% else %}
   /// @defgroup TLM
   /// @{
   uvm_tlm_analysis_fifo #(uvma_{{ name }}_mon_trn_c)  in_fifo  ; ///< Queue of monitor transactions
   uvm_analysis_export   #(uvma_{{ name }}_mon_trn_c)  in_export; ///< Port taking in transactions from monitor
   uvm_analysis_port     #(uvma_{{ name }}_mon_trn_c)  out_ap   ; ///< Port sending transactions to scoreboard
   /// @}
{% endif %}

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
    * Connects #in_export to #in_fifo.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Takes in transactions from #in_fifo, processes them and sends them out #out_ap.
    */
   extern virtual task run_phase(uvm_phase phase);
{% if full_duplex %}
   /**
    * Processes input {{ dir_1 }} monitor transactions.
    */
   extern virtual task process_{{ dir_1 }}(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * Processes input {{ dir_2 }} monitor transactions.
    */
   extern virtual task process_{{ dir_2 }}(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * {{ dir_1 }} prediction handler.
    */
   extern virtual task predict_{{ dir_1 }}(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * {{ dir_2 }} prediction handler.
    */
   extern virtual task predict_{{ dir_2 }}(ref uvma_{{ name }}_mon_trn_c trn);
{% else %}
   /**
    * Prediction handler.
    */
   extern virtual task predict(ref uvma_${name}_mon_trn_c trn);
{% endif %}
endclass : uvme_{{ name }}_st_prd_c


function uvme_{{ name }}_st_prd_c::new(string name="uvme_{{ name }}_st_prd", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_prd_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("{{ name_uppercase }}_PRD", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("{{ name_uppercase }}_PRD", "Context handle is null")
   end
{% if full_duplex %}
   {{ mode_1 }}_in_export = new("{{ mode_1 }}_in_export", this);
   {{ mode_1 }}_in_export = new("{{ mode_1 }}_in_export", this);
   {{ mode_1 }}_in_fifo = new("{{ mode_1 }}_in_fifo", this);
   {{ mode_2 }}_in_fifo = new("{{ mode_2 }}_in_fifo", this);
   {{ mode_1 }}_out_ap = new("{{ mode_1 }}_out_ap", this);
   {{ mode_2 }}_out_ap = new("{{ mode_2 }}_out_ap", this);
{% else %}
   in_export = new("in_export", this);
   in_fifo   = new("in_fifo"  , this);
   out_ap    = new("out_ap"   , this);
{% endif %}
endfunction : build_phase


function void uvme_{{ name }}_st_prd_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
{% if full_duplex %}
   {{ mode_1 }}_in_export.connect({{ mode_1 }}_in_fifo.analysis_export);
   {{ mode_2 }}_in_export.connect({{ mode_2 }}_in_fifo.analysis_export);
% else %}
   in_export.connect(in_fifo.analysis_export);
{% endif %}
endfunction: connect_phase

{% if full_duplex %}
task uvme_{{ name }}_st_prd_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   if (cfg.enabled) begin
      fork
         process_{{ dir_1 }}();
         process_{{ dir_2 }}();
      join_none
   end

endtask: run_phase


task uvme_{{ name }}_st_prd_c::process_{{ dir_1 }}();

   uvma_{{ name }}_mon_trn_c  in_trn, out_trn;

   forever begin
      // Get next transaction and copy it
      {{ dir_1 }}_in_fifo.get(in_trn);
      out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("out_trn");
      out_trn.copy(in_trn);

      // Can't expect {{ mode_1 }} agent to see transactions while in reset
      if (cntxt.{{ mode_1 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         trn.set_may_drop(1);
      end

      // Invoke prediction handler
      predict_{{ dir_1 }}(out_trn);
   end

endtask: process_{{ dir_1 }}


task uvme_{{ name }}_st_prd_c::process_{{ dir_2 }}();

   uvma_{{ name }}_mon_trn_c  in_trn, out_trn;

   forever begin
      // Get next transaction and copy it
      {{ dir_2 }}_in_fifo.get(in_trn);
      out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("out_trn");
      out_trn.copy(in_trn);

      // Can't expect {{ mode_2 }} agent to see transactions while in reset
      if (cntxt.{{ mode_2 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
         trn.set_may_drop(1);
      end

      // Invoke prediction handler
      predict_{{ dir_2 }}(out_trn);
   end

endtask: process_{{ dir_2 }}


task uvme_{{ name }}_st_prd_c::predict_{{ dir_1 }}(ref uvma_{{ name }}_mon_trn_c trn);

   // Send transaction to analysis port
   {{ dir_2 }}_out_ap.write(trn);

endtask: predict_{{ dir_1 }}


task uvme_{{ name }}_st_prd_c::predict_{{ dir_2 }}(ref uvma_{{ name }}_mon_trn_c trn);

   // Send transaction to analysis port
   {{ dir_2 }}_out_ap.write(trn);

endtask: predict_{{ dir_2 }}
{% else %}
task uvme_{{ name }}_st_prd_c::run_phase(uvm_phase phase);

   uvma_{{ name }}_mon_trn_c  in_trn, out_trn;

   super.run_phase(phase);

   if (cfg.enabled) begin
      forever begin
         // Get next transaction and copy it
         in_fifo.get(in_trn);
         out_trn = uvma_{{ name }}_mon_trn_c::type_id::create("out_trn");
         out_trn.copy(in_trn);

         // Can't expect {{ mode_1 }} agent to see transactions while in reset
         if (cntxt.{{ mode_1 }}_cntxt.reset_state != UVML_RESET_STATE_POST_RESET) begin
            out_trn.set_may_drop(1);
         end

         // Invoke prediction handler
         predict(out_trn);
      end
   end

endtask: run_phase


task uvme_{{ name }}_st_prd_c::predict(ref uvma_{{ name }}_mon_trn_c trn);

   // Send transaction to analysis port
   out_ap.write(trn);

endtask: predict
{% endif %}

`endif // __UVME_{{ name_uppercase }}_ST_PRD_SV__

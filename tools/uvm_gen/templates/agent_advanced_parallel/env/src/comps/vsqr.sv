// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_VSQR_SV__
`define __UVME_{{ upper(name) }}_ST_VSQR_SV__


/**
 * Component on which all {{ full_name }} VIP Self-Test virtual sequences are run.
 */
class uvme_{{ name }}_st_vsqr_c extends uvm_sequencer#(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   // Objects
   uvme_{{ name }}_st_cfg_c    cfg  ; ///< 
   uvme_{{ name }}_st_cntxt_c  cntxt; ///< 
   
   // Sequencer handles
   uvma_{{ name }}_vsqr_c  mstr_vsequencer; ///< 
   uvma_{{ name }}_vsqr_c  slv_vsequencer ; ///< 
   
   
   `uvm_component_utils_begin(uvme_{{ name }}_st_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvme_{{ name }}_st_vsqr_c


function uvme_{{ name }}_st_vsqr_c::new(string name="uvme_{{ name }}_st_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_{{ name }}_st_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`endif // __UVME_{{ upper(name) }}_ST_VSQR_SV__

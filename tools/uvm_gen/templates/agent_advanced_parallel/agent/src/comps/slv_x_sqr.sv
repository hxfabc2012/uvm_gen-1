// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SLV_A_SQR_SV__
`define __UVMA_{{ upper(name) }}_SLV_A_SQR_SV__


/**
 * Component running {{ full_name }} sequences extending uvma_{{ name }}_vseq_base_c.
 */
class uvma_{{ name }}_slv_a_sqr_c extends uvm_sequencer#(
   .REQ(uvma_{{ name }}_slv_a_seq_item_c),
   .RSP(uvma_{{ name }}_slv_a_seq_item_c)
);
   
   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   
   
   `uvm_component_utils_begin(uvma_{{ name }}_slv_a_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_slv_a_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvma_{{ name }}_slv_a_sqr_c


function uvma_{{ name }}_slv_a_sqr_c::new(string name="uvma_{{ name }}_slv_a_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_{{ name }}_slv_a_sqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`endif // __UVMA_{{ upper(name) }}_SLV_A_SQR_SV__

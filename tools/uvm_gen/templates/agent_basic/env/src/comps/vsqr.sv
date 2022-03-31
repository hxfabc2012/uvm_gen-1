// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_VSQR_SV__
`define __UVME_${name_uppercase}_ST_VSQR_SV__


/**
 * Component on which all ${name_normal_case} UVM Agent Self-Test Environment virtual sequences are run.
 */
class uvme_${name}_st_vsqr_c extends uvm_sequencer #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   /// @defgroup Objects
   /// @{
   uvme_${name}_st_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_st_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup Components
   /// @{
   uvma_${name}_sqr_c  active_sequencer ; ///< Sequencer handle for active agent
   uvma_${name}_sqr_c  passive_sequencer; ///< Sequencer handle for passive agent
   /// @}


   `uvm_component_utils_begin(uvme_${name}_st_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_sqr", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);

endclass : uvme_${name}_st_vsqr_c


function uvme_${name}_st_vsqr_c::new(string name="uvme_${name}_st_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_st_vsqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end

endfunction : build_phase


`endif // __UVME_${name_uppercase}_ST_VSQR_SV__

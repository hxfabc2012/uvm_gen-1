// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_VSQR_SV__
`define __UVME_${name_uppercase}_VSQR_SV__


/**
 * Component on which all ${name_normal_case} Block environment (uvme_${name}_env_c) virtual sequences are run.
 */
class uvme_${name}_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c    cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c  cntxt; ///< Environment context handle
   /// @}

   /// @defgroup Sequencer handles
   /// @{
   uvma_clk_sqr_c    clk_sequencer  ; ///< Clock agent sequencer
   uvma_reset_sqr_c  reset_sequencer; ///< Reset agent sequencer
   uvma_${name}_cp_sqr_c      cp_sequencer    ; ///< Control plane agent sequencer
   uvma_${name}_dp_in_sqr_c   dp_in_sequencer ; ///< Data plane input agent sequencer
   uvma_${name}_dp_out_sqr_c  dp_out_sequencer; ///< Data plane output agent sequencer
   /// @}


   `uvm_component_utils_begin(uvme_${name}_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_sqr", uvm_component parent=null);

   /**
    * Ensures #cfg & #cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);

endclass : uvme_${name}_vsqr_c


function uvme_${name}_vsqr_c::new(string name="uvme_${name}_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_vsqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_VSQR", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_VSQR", "Context handle is null")
   end

endfunction : build_phase


`endif // __UVME_${name_uppercase}_VSQR_SV__

// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_SQR_SV__
`define __UVMA_${name_uppercase}_SQR_SV__


/**
 * Component running ${name_normal_case} sequences of uvma_${name}_seq_item_c requests (and responses).
 * Provides sequence items for uvma_${name}_drv_c.
 */
class uvma_${name}_sqr_c extends uvm_sequencer #(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);

   /// @defgroup Objects
   /// @{
   uvma_${name}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_component_utils_begin(uvma_${name}_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_sqr", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);

endclass : uvma_${name}_sqr_c


function uvma_${name}_sqr_c::new(string name="uvma_${name}_sqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_${name}_sqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_SQR", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_SQR", "Context handle is null")
   end

endfunction : build_phase


`endif // __UVMA_${name_uppercase}_SQR_SV__

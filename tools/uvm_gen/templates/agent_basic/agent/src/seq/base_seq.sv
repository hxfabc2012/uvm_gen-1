// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_BASE_SEQ_SV__
`define __UVMA_${name_uppercase}_BASE_SEQ_SV__


/**
 * Abstract object from which all other ${name_normal_case} agent sequences must extend.
 * Subclasses must be run on ${name_normal_case} sequencer (uvma_${name}_sqr_c) instance.
 */
class uvma_${name}_base_seq_c extends uvm_sequence #(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);

   /// @defgroup Objects
   /// @{
   uvma_${name}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_object_utils(uvma_${name}_base_seq_c)
   `uvm_declare_p_sequencer(uvma_${name}_sqr_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_base_seq");

   /**
    * Assigns cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();

endclass : uvma_${name}_base_seq_c


function uvma_${name}_base_seq_c::new(string name="uvma_${name}_base_seq");

   super.new(name);

endfunction : new


task uvma_${name}_base_seq_c::pre_start();

   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;

endtask : pre_start


`endif // __UVMA_${name_uppercase}_BASE_SEQ_SV__

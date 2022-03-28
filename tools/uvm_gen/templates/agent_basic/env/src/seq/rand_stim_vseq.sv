// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_RAND_STIM_VSEQ_SV__
`define __UVME_${name_uppercase}_ST_RAND_STIM_VSEQ_SV__


/**
 * Sends a fixed number of completely random sequence items to the active sequencer.
 */
class uvme_${name}_st_rand_stim_vseq_c extends uvme_${name}_st_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to generate.
   /// @}


   `uvm_object_utils_begin(uvme_${name}_st_rand_stim_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_rand_stim_vseq");

   /**
    * Creates and sends #num_items of completely random uvma_${name}_seq_item_c instances to the active sequencer.
    */
   extern virtual task body();

endclass : uvme_${name}_st_rand_stim_vseq_c


function uvme_${name}_st_rand_stim_vseq_c::new(string name="uvme_${name}_st_rand_stim_vseq");

   super.new(name);

endfunction : new


task uvme_${name}_st_rand_stim_vseq_c::body();

   uvma_${name}_seq_item_c  seq_item;
   for (int unsigned ii=0; ii<num_items; ii++) begin
      `uvm_info("${name_uppercase}_ST_VSEQ", $sformatf("Generating item %0d of %0d", (ii+), num_items), UVM_HIGH)
      `uvm_do_on(seq_item, p_sequencer.active_sequencer)
   end

endtask : body


`endif // __UVME_${name_uppercase}_ST_RAND_STIM_VSEQ_SV__

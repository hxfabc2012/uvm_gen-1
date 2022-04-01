// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_SEQ_LIB_SV__
`define __UVMA_${name_uppercase}_SEQ_LIB_SV__


`include "uvma_${name}_base_seq.sv"


/**
 * Object cataloging the ${name_normal_case} UVM Agent sequences.
 */
class uvma_${name}_seq_lib_c extends uvml_seq_lib_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   `uvm_object_utils          (uvma_${name}_seq_lib_c)
   `uvm_sequence_library_utils(uvma_${name}_seq_lib_c)


   /**
    * 1. Initializes sequence library
    * 2. Adds sequences to library
    */
   extern function new(string name="uvma_${name}_seq_lib");

endclass : uvma_${name}_seq_lib_c


function uvma_${name}_seq_lib_c::new(string name="uvma_${name}_seq_lib");

   super.new(name);
   init_sequence_library();

endfunction : new


`endif // __UVMA_${name_uppercase}_SEQ_LIB_SV__

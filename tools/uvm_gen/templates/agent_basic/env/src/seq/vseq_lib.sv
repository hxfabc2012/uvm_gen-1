// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_VSEQ_LIB_SV__
`define __UVME_${name_uppercase}_ST_VSEQ_LIB_SV__


`include "uvme_${name}_st_base_vseq.sv"
`include "uvme_${name}_st_rand_stim_vseq.sv"


/**
 * Object cataloging the ${name_normal_case} self-test environment's virtual sequences.
 */
class uvme_${name}_st_vseq_lib_c extends uvm_sequence_library #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);

   `uvm_object_utils          (uvme_${name}_st_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_${name}_st_vseq_lib_c)

   /**
    * 1. Initializes sequence library
    * 2. Adds sequences to library
    */
   extern function new(string name="uvme_${name}_st_vseq_lib");

endclass : uvme_${name}_st_vseq_lib_c


function uvme_${name}_st_vseq_lib_c::new(string name="uvme_${name}_st_vseq_lib");

   super.new(name);
   init_sequence_library();
   add_sequence(uvme_${name}_st_rand_stim_vseq_c::get_type());

endfunction : new


`endif // __UVME_${name_uppercase}_ST_VSEQ_LIB_SV__

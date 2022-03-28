// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_VSEQ_LIB_SV__
`define __UVME_${name_uppercase}_VSEQ_LIB_SV__


`include "uvme_${name}_base_vseq.sv"
`include "uvme_${name}_${clk_agent_name}_vseq.sv"
`include "uvme_${name}_${reset_agent_name}_vseq.sv"
`include "uvme_${name}_reg_base_vseq.sv"
`include "uvme_${name}_reg_bit_bash_vseq.sv"
`include "uvme_${name}_reg_hw_reset_vseq.sv"


/**
 * Object cataloging the ${name_normal_case} environment's virtual sequences.
 */
class uvme_${name}_vseq_lib_c extends uvm_sequence_library #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   
   `uvm_object_utils          (uvme_${name}_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_${name}_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvme_${name}_vseq_lib");
   
endclass : uvme_${name}_vseq_lib_c


function uvme_${name}_vseq_lib_c::new(string name="uvme_${name}_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to uvme_${name}_seq_lib_c
   //      Ex: add_sequence(uvme_${name}_abc_seq_c::get_type());
   
endfunction : new


`endif // __UVME_${name_uppercase}_VSEQ_LIB_SV__

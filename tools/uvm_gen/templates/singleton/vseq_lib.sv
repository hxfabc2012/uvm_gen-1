// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __${pkg_name_uppercase}_${name_uppercase}_VSEQ_LIB_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_VSEQ_LIB_SV__


/**
 * TODO Describe ${pkg_name}_${name}_vseq_lib_c
 */
class ${pkg_name}_${name}_vseq_lib_c extends ${base_class};
   
   `uvm_object_utils          (${pkg_name}_${name}_vseq_lib_c)
   `uvm_sequence_library_utils(${pkg_name}_${name}_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="${pkg_name}_${name}_vseq_lib");
   
endclass : ${pkg_name}_${name}_vseq_lib_c


function ${pkg_name}_${name}_vseq_lib_c::new(string name="${pkg_name}_${name}_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to ${pkg_name}_${name}_vseq_lib_c
   //      Ex: add_sequence(${pkg_name}_${name}_abc_vseq_c::get_type());
   
endfunction : new


`endif // __${pkg_name_uppercase}_${name_uppercase}_VSEQ_LIB_SV__
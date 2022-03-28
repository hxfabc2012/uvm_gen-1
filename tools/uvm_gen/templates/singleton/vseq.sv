// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __${pkg_name_uppercase}_${name_uppercase}_VSEQ_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_VSEQ_SV__


/**
 * TODO Describe ${pkg_name}_${name}_vseq_c
 */
class ${pkg_name}_${name}_vseq_c extends ${base_class};
   
   
   
   
   `uvm_object_utils_begin(${pkg_name}_${name}_vseq_c)
      
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_vseq");
   
   /**
    * TODO Describe ${pkg_name}_${name}_vseq_c::body()
    */
   extern virtual task body();
   
endclass : ${pkg_name}_${name}_vseq_c


function ${pkg_name}_${name}_vseq_c::new(string name="${pkg_name}_${name}_vseq");
   
   super.new(name);
   
endfunction : new


task ${pkg_name}_${name}_vseq_c::body();
   
   // TODO Implement ${pkg_name}_${name}_vseq_c::body()
   
endtask : body


`endif // __${pkg_name_uppercase}_${name_uppercase}_VSEQ_SV__

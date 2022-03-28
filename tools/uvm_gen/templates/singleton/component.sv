// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __${pkg_name_uppercase}_${name_uppercase}_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_SV__


/**
 * TODO Describe ${pkg_name}_${name}_c
 */
class ${pkg_name}_${name}_c extends ${base_class};
   
   // Fields
   
   
   
   `uvm_component_utils_begin(${pkg_name}_${name}_c)
      // UVM Field Util Macros
   `uvm_component_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}", uvm_component parent=null);
   
   // Methods
   
   
endclass : ${pkg_name}_${name}_c


function ${pkg_name}_${name}_c::new(string name="${pkg_name}_${name}", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif // __${pkg_name_uppercase}_${name_uppercase}_SV__

// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/**
 * This file contains sample code that demonstrates how to add a new UVM Component to the ${name_normal_case} UVM Library.
 */


`ifndef __UVML_${name_uppercase}_MY_COMP_SV__
`define __UVML_${name_uppercase}_MY_COMP_SV__


/**
 * My sample component.
 */
class uvml_${name}_my_comp_c extends uvm_component;
   
   // Fields
   
   
   `uvm_component_utils_begin(uvml_${name}_my_comp_c)
      // UVM Field Macros
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_${name}_my_comp", uvm_component parent=null);
   
endclass : uvml_${name}_my_comp_c


function uvml_${name}_my_comp_c::new(string name="uvml_${name}_my_comp", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


`endif __UVML_${name_uppercase}_MY_COMP_SV__

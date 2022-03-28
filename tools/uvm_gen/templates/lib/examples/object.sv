// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/**
 * This file contains sample code that demonstrates how to add a new UVM Object to the ${name_normal_case} UVM Library.
 */


`ifndef __UVML_${name_uppercase}_MY_OBJ_SV__
`define __UVML_${name_uppercase}_MY_OBJ_SV__


/**
 * My sample object.
 */
class uvml_${name}_my_obj_c extends uvm_object;
   
   // Fields
   
   
   `uvm_object_utils_begin(uvml_${name}_my_obj_c)
      // UVM Field Macros
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvml_${name}_my_obj");
   
endclass : uvml_${name}_my_obj_c


function uvml_${name}_my_obj_c::new(string name="uvml_${name}_my_obj");
   
   super.new(name);
   
endfunction : new


`endif __UVML_${name_uppercase}_MY_OBJ_SV__

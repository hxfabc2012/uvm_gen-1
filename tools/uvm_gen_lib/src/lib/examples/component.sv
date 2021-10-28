// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
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

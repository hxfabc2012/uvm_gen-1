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
 * This file contains sample code that demonstrates how to add a new test to the ${name_normal_case} Self-Test Bench and UVM Test Library.
 */


`ifndef __UVMT_${name_uppercase}_MY_TEST_SV__
`define __UVMT_${name_uppercase}_MY_TEST_SV__


/**
 * TODO Describe uvmt_${name}_my_test_c
 */
class uvmt_${name}_my_test_c extends uvmt_${name}_base_test_c;
   
   rand uvme_${name}_st_my_vseq_c  my_vseq;
   
   
   `uvm_component_utils(uvmt_${name}_my_test_c)
   
   
   /**
    * Creates my_vseq.
    */
   extern function new(string name="uvmt_${name}_my_test", uvm_component parent=null);
   
   /**
    * Runs my_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_${name}_my_test_c


function uvmt_${name}_my_test_c::new(string name="uvmt_${name}_my_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   my_vseq = uvme_${name}_st_my_vseq_c::type_id::create("my_vseq");
   
endfunction : new


task uvmt_${name}_my_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting my virtual sequence:\n%s", my_vseq.sprint()), UVM_NONE)
   ${vseq_name}_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished my virtual sequence:\n%s", my_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_${name_uppercase}_MY_TEST_SV__

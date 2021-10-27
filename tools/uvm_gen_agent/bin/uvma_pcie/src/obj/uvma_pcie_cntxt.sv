// Copyright 2021 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_PCIE_CNTXT_SV__
`define __UVMA_PCIE_CNTXT_SV__


/**
 * Object encapsulating all state variables for all PCI Express agent (uvma_pcie_agent_c) components.
 */
class uvma_pcie_cntxt_c extends uvm_object;
   
   // Handle to agent interface
   virtual uvma_pcie_if  vif;
   
   // Integrals
   uvml_reset_state_enum  reset_state = UVML_RESET_STATE_PRE_RESET;
   
   // Events
   uvm_event  sample_cfg_e;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvma_pcie_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events.
    */
   extern function new(string name="uvma_pcie_cntxt");
   
   /**
    * TODO Describe uvma_pcie_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvma_pcie_cntxt_c


function uvma_pcie_cntxt_c::new(string name="uvma_pcie_cntxt");
   
   super.new(name);
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvma_pcie_cntxt_c::reset();
   
   // TODO Implement uvma_pcie_cntxt_c::reset()
   
endfunction : reset


`endif // __UVMA_PCIE_CNTXT_SV__

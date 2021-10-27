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


`ifndef __UVMA_PCIE_MON_TRN_SV__
`define __UVMA_PCIE_MON_TRN_SV__


/**
 * Object rebuilt from the PCI Express monitor.  Analog of uvma_pcie_seq_item_c.
 */
class uvma_pcie_mon_trn_c extends uvml_trn_mon_trn_c;
   
   // Data
   // TODO Add uvma_pcie_mon_trn_c data fields
   //      Ex: logic        abc;
   //          logic [7:0]  xyz;
   
   // Metadata
   uvma_pcie_cfg_c  cfg;
   
   
   `uvm_object_utils_begin(uvma_pcie_mon_trn_c)
      // TODO Add UVM field utils for data fields
      //      Ex: `uvm_field_int(abc, UVM_DEFAULT)
      //          `uvm_field_int(xyz, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_pcie_mon_trn");
   
endclass : uvma_pcie_mon_trn_c


function uvma_pcie_mon_trn_c::new(string name="uvma_pcie_mon_trn");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_PCIE_MON_TRN_SV__

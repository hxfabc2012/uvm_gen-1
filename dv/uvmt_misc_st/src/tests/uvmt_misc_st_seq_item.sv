// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_MISC_ST_SEQ_ITEM_SV__
`define __UVMT_MISC_ST_SEQ_ITEM_SV__


/**
 * TODO Describe uvmt_misc_st_seq_item_c
 */
class uvmt_misc_st_seq_item_c extends uvm_sequence_item;
   
   // Fields
   
   
   
   `uvm_object_utils_begin(uvmt_misc_st_seq_item_c)
      // UVM Field Util Macros
   `uvm_object_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_misc_st_seq_item");
   
   // Methods
   
   
endclass : uvmt_misc_st_seq_item_c


function uvmt_misc_st_seq_item_c::new(string name="uvmt_misc_st_seq_item");
   
   super.new(name);
   
endfunction : new


`endif // __UVMT_MISC_ST_SEQ_ITEM_SV__

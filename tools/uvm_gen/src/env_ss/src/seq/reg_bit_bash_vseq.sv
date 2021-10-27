// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__
`define __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__


/**
 * Virtual sequence that checks that  writable registers specified in the RAL
 * (uvme_${name}_ral_c) are writable in the DUT as well.
 */
class uvme_${name}_reg_bit_bash_vseq_c extends uvme_${name}_reg_base_vseq_c;
   
   `include "uvme_${name}_reg_ignore_bit_bash_list.sv"
   
   // Sub-sequences
   rand uvm_reg_bit_bash_seq  single_block_bit_bash_seq;
   rand uvm_reg_bit_bash_seq  all_blocks_bit_bash_seq[];
   
   
   `uvm_object_utils_begin(uvme_${name}_reg_bit_bash_vseq_c)
      `uvm_field_object      (single_block_bit_bash_seq, UVM_DEFAULT)
      `uvm_field_array_object(all_blocks_bit_bash_seq  , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      // TODO Constrain size of all_blocks_bit_bash_seq
      //      Ex: all_blocks_bit_bash_seq.size() == UVME_${name_uppercase}_MAX_NUM_CHANNELS;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_reg_bit_bash_vseq");
   
   /**
    * TODO Describe uvme_${name}_reg_bit_bash_vseq_c::run_single_block()
    */
   extern virtual task run_single_block();
   
   /**
    * TODO Describe uvme_${name}_reg_bit_bash_vseq_c::run_all_blocks()
    */
   extern virtual task run_all_blocks();
   
endclass : uvme_${name}_reg_bit_bash_vseq_c


`pragma protect begin


function uvme_${name}_reg_bit_bash_vseq_c::new(string name="uvme_${name}_reg_bit_bash_vseq");
   
   super.new(name);
   
   single_block_bit_bash_seq = uvm_reg_bit_bash_seq::type_id::create("single_block_bit_bash_seq");
   
   // TODO Initialize all_blocks_bit_bash_seq array
   //      Ex: all_blocks_bit_bash_seq = new[UVME_${name_uppercase}_MAX_NUM_CHANNELS];
   foreach (all_blocks_bit_bash_seq[ii]) begin
     all_blocks_bit_bash_seq[ii] = uvm_reg_bit_bash_seq::type_id::create($sformatf("all_blocks_bit_bash_seq[%0d]", ii));
   end
   
endfunction : new


task uvme_${name}_reg_bit_bash_vseq_c::run_single_block();
   
   // TODO Implement uvme_${name}_reg_bit_bash_vseq_c::run_single_block()
   //      Ex: single_block_bit_bash_seq.model = single_block;
   //          `uvm_send(single_block_bit_bash_seq)
   
endtask : run_single_block


task uvme_${name}_reg_bit_bash_vseq_c::run_all_blocks();
   
   // TODO Implement uvme_${name}_reg_bit_bash_vseq_c::run_all_blocks()
   //      Ex: fork
   //             begin
   //                foreach (cfg.ral.channels[_ii]) begin
   //                   fork
   //                      automatic int unsigned ii = _ii;
   //                      
   //                      begin
   //                         all_blocks_bit_bash_seq[ii].model = cfg.ral.channels[ii];
   //                         `uvm_send(all_blocks_bit_bash_seq[ii])
   //                      end
   //                   join_none
   //                end
   //                wait fork;
   //             end
   //          join
   
endtask : run_all_blocks


`pragma protect end


`endif // __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__

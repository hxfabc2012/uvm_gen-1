// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__
`define __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__


/**
 * Virtual sequence responsible for asserting reset with the ${name_normal_case} DUT.
 */
class uvme_${name}_${reset_agent_name}_vseq_c extends uvme_${name}_base_vseq_c;
   
   // TODO Add reset sequence to uvme_${name}_${reset_agent_name}_vseq_c
   //      Ex: rand uvma_${reset_agent_type}_simple_seq_c  ${reset_agent_name}_seq;
   
   `uvm_object_utils_begin(uvme_${name}_${reset_agent_name}_vseq_c)
      // TODO Add sub-sequence(s) utility macros
      //      Ex: `uvm_field_object(${reset_agent_name}_seq, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   // TODO Add constraint(s) to uvme_${name}_${reset_agent_name}_vseq_c
   //      Ex: constraint ${reset_agent_name}_seq_cons {
   //             ${reset_agent_name}_seq.abc == 123;
   //          }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_${reset_agent_name}_vseq_c");
   
   /**
    * TODO Describe uvme_${name}_${reset_agent_name}_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_${name}_${reset_agent_name}_vseq_c


function uvme_${name}_${reset_agent_name}_vseq_c::new(string name="uvme_${name}_${reset_agent_name}_vseq_c");
   
   super.new(name);
   
   // TODO Create sub-sequence(s)
   //      Ex: ${reset_agent_name}_seq = uvma_${reset_agent_type}_simple_seq_c::type_id::create("${reset_agent_name}_seq");
   
endfunction : new


task uvme_${name}_${reset_agent_name}_vseq_c::body();
   
   // TODO Implement uvme_${name}_${reset_agent_name}_vseq_c::body()
   //      Ex: `uvm_do_with(${reset_agent_name}_seq, p_sequencer.${reset_agent_name}_sequencer)
   
endtask : body


`endif // __UVME_${name_uppercase}_${reset_agent_name_uppercase}_VSEQ_SV__

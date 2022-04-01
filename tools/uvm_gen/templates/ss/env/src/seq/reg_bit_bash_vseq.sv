// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__
`define __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__


/**
 * Virtual sequence checking that the every bit in a register block is accessible from the ${name_normal_case} Sub-System DUT.
 */
class uvme_${name}_reg_bit_bash_vseq_c extends uvme_${name}_reg_base_vseq_c;

   `include "uvme_${name}_reg_bit_bash_vseq_ignore_list.sv"

   rand uvm_reg_bit_bash_seq  bit_bash_seq; ///< Sequence to be run


   `uvm_object_utils_begin(uvme_${name}_reg_bit_bash_vseq_c)
      `uvm_field_object(bit_bash_seq, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Creates bit_bash_seq.
    */
   extern function new(string name="uvme_${name}_reg_bit_bash_vseq");

   /**
    * Runs #bit_bash_seq against #single_block.
    */
   extern virtual task run_single_block();

   /**
    * Runs #bit_bash_seq against uvme_${name}_reg_block_c.
    */
   extern virtual task run_all_blocks();

endclass : uvme_${name}_reg_bit_bash_vseq_c


function uvme_${name}_reg_bit_bash_vseq_c::new(string name="uvme_${name}_reg_bit_bash_vseq");

   super.new(name);
   bit_bash_seq = uvm_reg_bit_bash_seq::type_id::create("bit_bash_seq");

endfunction : new


task uvme_${name}_reg_bit_bash_vseq_c::run_single_block();

   bit_bash_seq.model = single_block;
   `uvm_send(bit_bash_seq)

endtask : run_single_block


task uvme_${name}_reg_bit_bash_vseq_c::run_all_blocks();

   bit_bash_seq.model = cfg.${name}_reg_block;
   `uvm_send(bit_bash_seq)

endtask : run_all_blocks


`endif // __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_SV__

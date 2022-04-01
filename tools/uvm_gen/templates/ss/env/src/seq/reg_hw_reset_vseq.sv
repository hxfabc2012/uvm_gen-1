// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_SV__
`define __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_SV__


/**
 * Virtual sequence checking that the hardware reset values in a register block match the ${name_normal_case} Sub-System DUT.
 */
class uvme_${name}_reg_hw_reset_vseq_c extends uvme_${name}_reg_base_vseq_c;

   `include "uvme_${name}_reg_hw_reset_vseq_ignore_list.sv"

   rand uvm_reg_hw_reset_seq  hw_reset_seq; ///< Sequence to be run


   `uvm_object_utils_begin(uvme_${name}_reg_hw_reset_vseq_c)
      `uvm_field_object(hw_reset_seq, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Creates hw_reset_seq.
    */
   extern function new(string name="uvme_${name}_reg_hw_reset_vseq");

   /**
    * Runs #hw_reset_seq against #single_block.
    */
   extern virtual task run_single_block();

   /**
    * Runs #hw_reset_seq against uvme_${name}_reg_block_c.
    */
   extern virtual task run_all_blocks();

endclass : uvme_${name}_reg_hw_reset_vseq_c


function uvme_${name}_reg_hw_reset_vseq_c::new(string name="uvme_${name}_reg_hw_reset_vseq");

   super.new(name);
   hw_reset_seq = uvm_reg_hw_reset_seq::type_id::create("hw_reset_seq");

endfunction : new


task uvme_${name}_reg_hw_reset_vseq_c::run_single_block();

   hw_reset_seq.model = single_block;
   `uvm_send(hw_reset_seq)

endtask : run_single_block


task uvme_${name}_reg_hw_reset_vseq_c::run_all_blocks();

   hw_reset_seq.model = cfg.${name}_reg_block;
   `uvm_send(hw_reset_seq)

endtask : run_all_blocks


`endif // __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_SV__

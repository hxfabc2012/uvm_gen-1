// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_REG_BIT_BASH_TEST_SV__
`define __UVMT_${name_uppercase}_REG_BIT_BASH_TEST_SV__


/**
 * Test checking the accessibility of every bit of every register in the ${name_normal_case} Sub-System DUT.
 */
class uvmt_${name}_reg_bit_bash_test_c extends uvmt_${name}_reg_base_test_c;

   rand uvme_${name}_reg_bit_bash_vseq_c  bit_bash_vseq; ///< Virtual sequence to be run


   `uvm_component_utils(uvmt_${name}_reg_bit_bash_test_c)


   /**
    * By default, we only test a single register block.
    */
   constraint defaults_cons {
      soft bit_bash_vseq.single_block_mode == 1;
   }


   /**
    * Creates bit_bash_vseq.
    */
   extern function new(string name="uvmt_${name}_reg_bit_bash_test", uvm_component parent=null);

   /**
    * Runs bit_bash_vseq on vsequencer.
    */
   extern virtual task configure_phase(uvm_phase phase);

endclass : uvmt_${name}_reg_bit_bash_test_c


function uvmt_${name}_reg_bit_bash_test_c::new(string name="uvmt_${name}_reg_bit_bash_test", uvm_component parent=null);

   super.new(name, parent);
   bit_bash_vseq = uvme_${name}_reg_bit_bash_vseq_c::type_id::create("bit_bash_vseq");

endfunction : new


task uvmt_${name}_reg_bit_bash_test_c::configure_phase(uvm_phase phase);

   super.configure_phase(phase);

   `uvm_info("TEST", $sformatf("Starting bit bash virtual sequence:\n%s", bit_bash_vseq.sprint()), UVM_NONE)
   bit_bash_vseq.single_block = test_cfg.selected_reg_block;
   bit_bash_vseq.start(vsequencer);
   `uvm_info("TEST", "Finished bit bash virtual sequence", UVM_NONE)

endtask : configure_phase


`endif // __UVMT_${name_uppercase}_REG_BIT_BASH_TEST_SV__

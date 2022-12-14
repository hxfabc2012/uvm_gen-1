// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new test to the ${name_normal_case} Block Test Bench and UVM Test Library.


`ifndef __UVMT_${name_uppercase}_MY_TEST_SV__
`define __UVMT_${name_uppercase}_MY_TEST_SV__


/**
 * Test which runs virtual sequence 'my_vseq' for 10 items of stimulus.
 */
class uvmt_${name}_my_test_c extends uvmt_${name}_base_test_c;

   rand uvme_${name}_my_vseq_c  my_vseq; ///< Virtual sequence to be run


   `uvm_component_utils(uvmt_${name}_my_test_c)


   /**
    *
    */
   constraint my_vseq_cons {
      my_vseq.num_items == 10;
   }


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
   my_vseq = uvme_${name}_my_vseq_c::type_id::create("my_vseq");

endfunction : new


task uvmt_${name}_my_test_c::main_phase(uvm_phase phase);

   super.main_phase(phase);

   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting my virtual sequence:\n%s", my_vseq.sprint()), UVM_NONE)
   my_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished my virtual sequence:\n%s", my_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);

endtask : main_phase


`endif // __UVMT_${name_uppercase}_MY_TEST_SV__

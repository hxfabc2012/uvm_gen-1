// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_ST_RAND_STIM_TEST_SV__
`define __UVMT_${name_uppercase}_ST_RAND_STIM_TEST_SV__


/**
 * Runs uvme_${name}_st_rand_stim_vseq_c with default parameters and scoreboarding enabled.
 */
class uvmt_${name}_st_rand_stim_test_c extends uvmt_${name}_st_base_test_c;

   rand uvme_${name}_st_rand_stim_vseq_c  rand_stim_vseq; ///< Virtual sequence to be run during #main_phase()


   `uvm_component_utils(uvmt_${name}_st_rand_stim_test_c)


   /**
    * Overrides number of stimulus items to drive with CLI argument (if present).
    */
   constraint vseq_cons {
      if (test.cli_num_items_override) {
         rand_stim_vseq.num_items == test_cfg.cli_num_items_parsed;
      }
   }


   /**
    * Creates rand_stim_vseq.
    */
   extern function new(string name="uvmt_${name}_st_rand_stim_test", uvm_component parent=null);

   /**
    * Runs rand_stim_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);

endclass : uvmt_${name}_st_rand_stim_test_c


function uvmt_${name}_st_rand_stim_test_c::new(string name="uvmt_${name}_st_rand_stim_test", uvm_component parent=null);

   super.new(name, parent);
   rand_stim_vseq = uvme_${name}_st_rand_stim_vseq_c::type_id::create("rand_stim_vseq");

endfunction : new


task uvmt_${name}_st_rand_stim_test_c::main_phase(uvm_phase phase);

   super.main_phase(phase);

   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   rand_stim_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);

endtask : main_phase


`endif // __UVMT_${name_uppercase}_ST_RAND_STIM_TEST_SV__

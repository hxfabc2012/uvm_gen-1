// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_PRINT_TEST_SV__
`define __UVMT_{{ upper(name) }}_ST_PRINT_TEST_SV__


/**
 * TODO Describe uvmt_{{ name }}_st_print_test_c
 */
class uvmt_{{ name }}_st_print_test_c extends uvmt_{{ name }}_st_base_test_c;
   
   rand uvme_{{ name }}_st_print_vseq_c  print_vseq; ///< 
   
   
   `uvm_component_utils(uvmt_{{ name }}_st_print_test_c)
   
   
   constraint env_cfg_cons {
      env_cfg.scoreboarding_enabled == 0;
   }
   
   
   /**
    * Creates print_vseq.
    */
   extern function new(string name="uvmt_{{ name }}_st_print_test", uvm_component parent=null);
   
   /**
    * Runs print_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_{{ name }}_st_print_test_c


function uvmt_{{ name }}_st_print_test_c::new(string name="uvmt_{{ name }}_st_print_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   print_vseq = uvme_{{ name }}_st_print_vseq_c::type_id::create("print_vseq");
   
endfunction : new


task uvmt_{{ name }}_st_print_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting print virtual sequence:\n%s", print_vseq.sprint()), UVM_NONE)
   print_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished print virtual sequence:\n%s", print_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_{{ upper(name) }}_ST_PRINT_TEST_SV__

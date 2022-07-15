// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name.upper() }}_ST_RAND_STIM_TEST_SV__
`define __UVMT_{{ name.upper() }}_ST_RAND_STIM_TEST_SV__


/**
 * TODO Describe uvmt_{{ name }}_st_rand_stim_test_c
 */
class uvmt_{{ name }}_st_rand_stim_test_c extends uvmt_{{ name }}_st_base_test_c;

   rand uvme_{{ name }}_st_rand_stim_vseq_c  rand_stim_vseq; ///<


   `uvm_component_utils(uvmt_{{ name }}_st_rand_stim_test_c)


   /**
    * Describe rand_stim_vseq_cons
    */
   constraint rand_stim_vseq_cons {
      if (test_cfg.cli_num_seq_items_override) {
         rand_stim_vseq.num_{{ tx }}_seq_items == cli_num_seq_items_parsed;
         rand_stim_vseq.num_{{ rx }}_seq_items == cli_num_seq_items_parsed;
      }
   }


   /**
    * Creates rand_stim_vseq.
    */
   extern function new(string name="uvmt_{{ name }}_st_rand_stim_test", uvm_component parent=null);

   /**
    * Runs rand_stim_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);

   /**
    * TODO Describe uvmt_{{ name }}_st_rand_stim_test_c::check_phase()
    */
   extern virtual function void check_phase(uvm_phase phase);

endclass : uvmt_{{ name }}_st_rand_stim_test_c


function uvmt_{{ name }}_st_rand_stim_test_c::new(string name="uvmt_{{ name }}_st_rand_stim_test", uvm_component parent=null);

   super.new(name, parent);
   rand_stim_vseq = uvme_{{ name }}_st_rand_stim_vseq_c::type_id::create("rand_stim_vseq");

endfunction : new


task uvmt_{{ name }}_st_rand_stim_test_c::main_phase(uvm_phase phase);

   super.main_phase(phase);
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   rand_stim_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished rand_stim virtual sequence:\n%s", rand_stim_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);

endtask : main_phase


function void uvmt_{{ name }}_st_rand_stim_test_c::check_phase(uvm_phase phase);

   super.check_phase(phase);
   if (env_cfg.scoreboarding_enabled) begin
      if (env_cntxt.sb_{{ tx }}_cntxt.match_count < rand_stim_vseq.num_{{ tx }}_seq_items) begin
         `uvm_error("TEST", $sformatf("{{ tx.upper() }} scoreboard saw less than %0d matches: %0d", rand_stim_vseq.num_{{ tx }}_seq_items, env_cntxt.sb_{{ tx }}_cntxt.match_count))
      end
      if (env_cntxt.sb_{{ rx }}_cntxt.match_count < rand_stim_vseq.num_{{ rx }}_seq_items) begin
         `uvm_error("TEST", $sformatf("{{ rx.upper() }} scoreboard saw less than %0d matches: %0d", rand_stim_vseq.num_{{ rx }}_seq_items, env_cntxt.sb_{{ rx }}_cntxt.match_count))
      end
      if (env_cntxt.sb_{{ mode_1 }}_cntxt.match_count < rand_stim_vseq.num_{{ tx }}_seq_items) begin
         `uvm_error("TEST", $sformatf("{{ mode_1.upper() }} scoreboard saw less than %0d matches: %0d", rand_stim_vseq.num_{{ tx }}_seq_items, env_cntxt.sb_{{ mode_1 }}_cntxt.match_count))
      end
      if (env_cntxt.sb_{{ mode_2 }}_cntxt.match_count < rand_stim_vseq.num_{{ rx }}_seq_items) begin
         `uvm_error("TEST", $sformatf("{{ mode_2.upper() }} scoreboard saw less than %0d matches: %0d", rand_stim_vseq.num_{{ rx }}_seq_items, env_cntxt.sb_{{ mode_2 }}_cntxt.match_count))
      end
   end

endfunction : check_phase


`endif // __UVMT_{{ name.upper() }}_ST_RAND_STIM_TEST_SV__

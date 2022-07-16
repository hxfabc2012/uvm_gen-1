// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c
 */
class uvma_{{ name }}_{{ tx }}_drv_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_{{ tx }}_drv_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_drv_vseq");

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::body()
    */
   extern virtual task body();

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_for_reset()
    */
   extern task wait_for_reset();

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::post_reset_init()
    */
   extern task post_reset_init();

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::drv_loop()
    */
   extern task drv_loop();

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::reset_trigger()
    */
   extern task reset_trigger();

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::process_seq_item()
    */
   extern function void process_seq_item(ref uvma_{{ name }}_seq_item_c seq_item);

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::drive()
    */
   extern virtual task drive(ref uvma_{{ name }}_seq_item_c seq_item);

   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_clk()
    */
   extern task wait_clk();

endclass : uvma_{{ name }}_{{ tx }}_drv_vseq_c


function uvma_{{ name }}_{{ tx }}_drv_vseq_c::new(string name="uvma_{{ name }}_{{ tx }}_drv_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::body();

   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", "{{ tx.upper() }} Driver Virtual Sequence has started", UVM_HIGH)
   forever begin
      fork
         begin : main
            wait_for_reset ();
            post_reset_init();
            drv_loop       ();
         end
         begin : reset
            reset_trigger();
         end
      join_any
      disable fork;
   end

endtask : body


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_for_reset();

   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", "Waiting for post_reset", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", "Done waiting for post_reset", UVM_HIGH)

endtask : wait_for_reset


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::post_reset_init();

   uvma_{{ name }}_training_vseq_c  training_vseq;
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", {"Starting training sequence:\n", training_vseq.sprint()}, UVM_HIGH)
   `uvm_do_on(training_vseq, p_sequencer)
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", {"Finished training sequence:\n", training_vseq.sprint()}, UVM_HIGH)

endtask : post_reset_init


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::drv_loop();

   uvma_{{ name }}_seq_item_c  seq_item;

   forever begin
      `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", "Waiting for next seq_item", UVM_DEBUG)
      p_sequencer.get_next_item(seq_item);
      `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", $sformatf("Received seq_item:\n%s", seq_item.sprint()), UVM_DEBUG)
      process_seq_item             (seq_item);
      drive                        (seq_item);
      p_sequencer.seq_item_ap.write(seq_item);
      `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", {"Done with seq_item:\n", seq_item.sprint()}, UVM_DEBUG)
      p_sequencer.item_done();
   end

endtask : drv_loop


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::reset_trigger();

   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", "Mid-sim reset detected. Resetting main loop, this may kill some sequences.", UVM_NONE)

endtask : reset_trigger


function void uvma_{{ name }}_{{ tx }}_drv_vseq_c::process_seq_item(ref uvma_{{ name }}_seq_item_c seq_item);

   seq_item.cfg       = cfg;
   seq_item.direction = UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }};
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", $sformatf("Processed seq_item:\n%s", seq_item.sprint()), UVM_DEBUG)
   if (!seq_item.is_idle) begin
      `uvml_hrtbt_owner(p_sequencer)
   end

endfunction : process_seq_item


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::drive(ref uvma_{{ name }}_seq_item_c seq_item);

   uvma_{{ name }}_{{ tx }}_seq_item_c  req;
   bit           seq_item_bits[];
   int unsigned  num_seq_item_bits;

   uvm_default_packer.big_endian = cfg.big_endian;
   num_seq_item_bits = seq_item.pack(seq_item_bits);
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", $sformatf("Driving %0d bits of serial data", num_seq_item_bits), UVM_DEBUG)
   for (int ii=num_seq_item_bits-1; ii>=0; ii--) begin
      `uvm_create_on(req, p_sequencer.{{ tx }}_serial_sequencer)
      `uvm_rand_send_pri_with(req, `UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_SEQ_ITEM_PRI, {
         {{ tx }}p == seq_item_bits[ii];
      })
   end
   `uvm_info("{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ", $sformatf("Finished driving %0d bits of serial data", num_seq_item_bits), UVM_DEBUG)

endtask : drive


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_clk();

   @(cntxt.vif.drv_{{ tx }}_cb);

endtask : wait_clk


`endif // __UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_VSEQ_SV__

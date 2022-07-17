// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ_SV__


/**
 * Virtual Sequence taking in uvma_{{ name }}_seq_item_c instances and driving uvma_{{ name }}_{{ rx }}_drv_c with
 * {{ rx.upper() }} Sequence Items (uvma_{{ name }}_{{ rx }}_seq_item_c).
 */
class uvma_{{ name }}_{{ rx }}_drv_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_{{ rx }}_drv_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ rx }}_drv_vseq");

   /**
    * Infinite loop maintaining 2 threads:
    * 1. Main sequence: wait for reset, link training, drive traffic
    * 2. Reset trigger for mid-sim reset which resets the main sequence.
    */
   extern virtual task body();

   /**
    * Wait for reset state change in #cntxt.
    */
   extern task wait_for_reset();

   /**
    * Waits for monitor to be ready for {{ rx.upper() }} bitstream.
    */
   extern task post_reset_init();

   /**
    * Infinite loop taking in and converting uvma_{{ name }}_seq_item_c instances to uvma_{{ name }}_{{ rx }}_seq_item_c.
    */
   extern task drv_loop();

   /**
    * Waits for mid-sim reset state change in #cntxt.
    */
   extern task reset_trigger();

   /**
    * Modifies #seq_item before packing it.
    */
   extern function void process_seq_item(ref uvma_{{ name }}_seq_item_c seq_item);

   /**
    * Packs #seq_item and produces a uvma_{{ name }}_{{ rx }}_seq_item_c instance for every 2 packed bits.
    */
   extern virtual task drive(ref uvma_{{ name }}_seq_item_c seq_item);

   /**
    * Waits for the next {{ rx.upper() }} virtual interface clock edge.
    */
   extern virtual task wait_clk();

endclass : uvma_{{ name }}_{{ rx }}_drv_vseq_c


function uvma_{{ name }}_{{ rx }}_drv_vseq_c::new(string name="uvma_{{ name }}_{{ rx }}_drv_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::body();

   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "{{ name.upper() }} Driver Virtual Sequence has started", UVM_HIGH)
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


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::wait_for_reset();

   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Waiting for post_reset", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Done waiting for post_reset", UVM_HIGH)

endtask : wait_for_reset


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::post_reset_init();

   uvma_{{ name }}_training_vseq_c  training_vseq;
   `uvm_create_on(training_vseq, p_sequencer)
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", {"Starting training sequence:\n", training_vseq.sprint()}, UVM_HIGH)
   `uvm_do(training_vseq)
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", {"Finished training sequence:\n", training_vseq.sprint()}, UVM_HIGH)
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Waiting for SYNCING state", UVM_HIGH)
   wait (cntxt.{{ rx }}_mon_fsm_cntxt.state == UVMA_{{ name.upper() }}_MON_FSM_SYNCING);
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Done waiting for SYNCING state", UVM_HIGH)

endtask : post_reset_init


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::drv_loop();

   uvma_{{ name }}_seq_item_c  seq_item;
   forever begin
      `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Waiting for next seq_item", UVM_DEBUG)
      p_sequencer.get_next_item(seq_item);
      `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", $sformatf("Received seq_item:\n%s", seq_item.sprint()), UVM_HIGH)
      process_seq_item             (seq_item);
      drive                        (seq_item);
      p_sequencer.seq_item_ap.write(seq_item);
      `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", {"Done with seq_item:\n", seq_item.sprint()}, UVM_DEBUG)
      p_sequencer.item_done();
   end

endtask : drv_loop


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::reset_trigger();

   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", "Mid-sim reset detected. Resetting main loop, this may kill some sequences.", UVM_NONE)

endtask : reset_trigger


function void uvma_{{ name }}_{{ rx }}_drv_vseq_c::process_seq_item(ref uvma_{{ name }}_seq_item_c seq_item);

   seq_item.cfg = cfg;
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", $sformatf("Processed seq_item:\n%s", seq_item.sprint()), UVM_DEBUG)
   if (seq_item.header == UVMA_{{ name.upper() }}_HEADER_DATA) begin
      `uvml_hrtbt_owner(p_sequencer)
   end

endfunction : process_seq_item


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::drive(ref uvma_{{ name }}_seq_item_c seq_item);

   uvma_{{ name }}_{{ rx }}_seq_item_c  req;
   bit           seq_item_bits[];
   int unsigned  num_seq_item_bits;

   uvm_default_packer.big_endian = uvma_{{ name }}_big_endian;
   num_seq_item_bits = seq_item.pack(seq_item_bits);
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", $sformatf("Driving %0d bits of serial data", num_seq_item_bits), UVM_DEBUG)
   for (int unsigned ii=0; ii<num_seq_item_bits; ii+=2) begin
      `uvm_create_on(req, p_sequencer.{{ rx }}_sequencer)
      `uvm_rand_send_pri_with(req, `UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_SEQ_ITEM_PRI, {
         {{ rx }}0p == seq_item_bits[ii+0];
         {{ rx }}1p == seq_item_bits[ii+1];
      })
   end
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ", $sformatf("Finished driving %0d bits of serial data", num_seq_item_bits), UVM_DEBUG)

endtask : drive


task uvma_{{ name }}_{{ rx }}_drv_vseq_c::wait_clk();

   @(cntxt.vif.drv_{{ rx }}_cb);

endtask : wait_clk


`endif // __UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_VSEQ_SV__

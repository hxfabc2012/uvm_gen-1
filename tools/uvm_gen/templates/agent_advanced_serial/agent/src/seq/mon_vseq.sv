// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_MON_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_MON_VSEQ_SV__


/**
 * Virtual Sequence taking in Phy Monitor Transactions and creating {{ full_name }} transactions (uvma_{{ name }}_mon_trn_c).
 * Includes {{ full_name }} monitor Finite State Machine implementation.
 */
class uvma_{{ name }}_mon_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_mon_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_vseq");

   /**
    * Infinite loop maintaining 3 threads:
    * 1. {{ tx.upper() }} main sequence: wait for reset, link training, rebuild traffic from Phy transactions
    * 2. {{ rx.upper() }} main sequence: wait for reset, link training, rebuild traffic from Phy transactions
    * 3. Reset trigger for mid-sim reset which resets main sequences.
    */
   extern virtual task body();

   /**
    * Wait for reset state change in #cntxt.
    */
   extern task wait_for_reset_{{ tx }}();

   /**
    * Wait for reset state change in #cntxt.
    */
   extern task wait_for_reset_{{ rx }}();

   /**
    * Infinite loop taking in Phy Monitor Transactions and generating Monitor Transactions for {{ tx.upper() }}.
    */
   extern task monitor_{{ tx }}();

   /**
    * Infinite loop taking in Phy Monitor Transactions and generating Monitor Transactions for {{ rx.upper() }}.
    */
   extern task monitor_{{ rx }}();

   /**
    * Waits for mid-sim reset state change in #cntxt.
    */
   extern task reset_trigger();

   /**
    * Performs differential decoding on #p & #n.
    */
   extern function logic decode_bit(logic p, logic n);

   /**
    * Returns short string for use in `uvm_info() IDs.
    */
   extern function string get_direction_str(uvma_{{ name }}_direction_enum direction);

   /**
    * Monitor Finite State Machine entry point. Returns '1' if enough data is present in #fsm_cntxt for a transaction.
    */
   extern function bit fsm(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction);

   /**
    * Unpacks Monitor Transaction from bits in {{ tx.upper() }} #cntxt.
    */
   extern function void unpack_{{ tx }}_trn(output uvma_{{ name }}_mon_trn_c mon_trn);

   /**
    * Unpacks Monitor Transaction from bits in {{ rx.upper() }} #cntxt.
    */
   extern function void unpack_{{ rx }}_trn(output uvma_{{ name }}_mon_trn_c mon_trn);

   /**
    * INIT FSM evaluation function.
    */
   extern function uvma_{{ name }}_mon_fsm_enum fsm_init(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   /**
    * TRAINING FSM evaluation function.
    */
   extern function uvma_{{ name }}_mon_fsm_enum fsm_training(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   /**
    * SYNCING FSM evaluation function.
    */
   extern function uvma_{{ name }}_mon_fsm_enum fsm_syncing(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   /**
    * SYNCED FSM evaluation function.
    */
   extern function uvma_{{ name }}_mon_fsm_enum fsm_synced(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

endclass : uvma_{{ name }}_mon_vseq_c


function uvma_{{ name }}_mon_vseq_c::new(string name="uvma_{{ name }}_mon_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_mon_vseq_c::body();

   `uvm_info("{{ name.upper() }}_MON_VSEQ", "Monitor virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin
            wait_for_reset_{{ tx }}();
            monitor_{{ tx }}       ();
         end
         begin
            wait_for_reset_{{ rx }}();
            monitor_{{ rx }}       ();
         end
         begin
            reset_trigger();
         end
      join_any
      disable fork;
   end

endtask : body


task uvma_{{ name }}_mon_vseq_c::wait_for_reset_{{ tx }}();

   `uvm_info("{{ name.upper() }}_MON_VSEQ", "Waiting for post_reset on {{ tx.upper() }}", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_MON_VSEQ", "Done waiting for post_reset on {{ tx.upper() }}", UVM_HIGH)

endtask : wait_for_reset_{{ tx }}


task uvma_{{ name }}_mon_vseq_c::wait_for_reset_{{ rx }}();

   `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", "Waiting for post_reset on {{ rx.upper() }}", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", "Done waiting for post_reset on {{ rx.upper() }}", UVM_HIGH)

endtask : wait_for_reset_{{ rx }}


task uvma_{{ name }}_mon_vseq_c::monitor_{{ tx }}();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  phy_trn;
{% else %}   uvma_{{ name }}_{{ tx }}_mon_trn_c  phy_trn;
{% endif %}   uvma_{{ name }}_mon_trn_c  mon_trn;
   bit  unpack_trn;
   bit  trn_data[];

   forever begin
      get_{{ tx }}_phy_mon_trn(phy_trn);
      `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ tx.upper() }}", $sformatf("Got Phy Monitor Transaction:\n%s", phy_trn.sprint()), UVM_DEBUG)
{% if symmetric %}      cntxt.{{ tx }}_mon_fsm_cntxt.data_q.push_back(decode_bit(phy_trn.dp, phy_trn.dn));
{% else %}      cntxt.{{ tx }}_mon_fsm_cntxt.data_q.push_back(decode_bit(phy_trn.{{ tx }}p, phy_trn.{{ tx }}n));
{% endif %}      cntxt.{{ tx }}_mon_fsm_cntxt.timestamps_q.push_back(phy_trn.get_timestamp_start());
      `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ tx.upper() }}", $sformatf("Monitor has accumulated %0d bits", cntxt.{{ tx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
      unpack_trn = fsm(cntxt.{{ tx }}_mon_fsm_cntxt, UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }});
      if (unpack_trn) begin
         unpack_{{ tx }}_trn(mon_trn);
         if (mon_trn.header != UVMA_{{ name.upper() }}_HEADER_IDLE) begin
            `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ tx.upper() }}", $sformatf("Unpacked Data Monitor Transaction:\n%s", mon_trn.sprint()), UVM_HIGH)
            `uvml_hrtbt_owner(p_sequencer)
            write_{{ tx }}_mon_trn(mon_trn);
         end
      end
   end

endtask : monitor_{{ tx }}


task uvma_{{ name }}_mon_vseq_c::monitor_{{ rx }}();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  phy_trn;
{% else %}   uvma_{{ name }}_{{ rx }}_mon_trn_c  phy_trn;
{% endif %}   uvma_{{ name }}_mon_trn_c  mon_trn;
   bit  unpack_trn;
   bit  trn_data[];

   forever begin
      get_{{ rx }}_phy_mon_trn(phy_trn);
      `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", $sformatf("Got Phy Monitor Transaction:\n%s", phy_trn.sprint()), UVM_DEBUG)
{% if symmetric %}      cntxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(decode_bit(phy_trn.dp, phy_trn.dn));
{% else %}      cntxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(decode_bit(phy_trn.{{ rx }}0p, phy_trn.{{ rx }}0n));
      cntxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(decode_bit(phy_trn.{{ rx }}1p, phy_trn.{{ rx }}1n));
      cntxt.{{ rx }}_mon_fsm_cntxt.timestamps_q.push_back(phy_trn.get_timestamp_start());
{% endif %}      cntxt.{{ rx }}_mon_fsm_cntxt.timestamps_q.push_back(phy_trn.get_timestamp_start());
      `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", $sformatf("Monitor has accumulated %0d bits", cntxt.{{ rx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
      unpack_trn = fsm(cntxt.{{ rx }}_mon_fsm_cntxt, UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }});
      if (unpack_trn) begin
         unpack_{{ rx }}_trn(mon_trn);
         if (mon_trn.header != UVMA_{{ name.upper() }}_HEADER_IDLE) begin
            `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", $sformatf("Unpacked Data Monitor Transaction:\n%s", mon_trn.sprint()), UVM_HIGH)
            `uvml_hrtbt_owner(p_sequencer)
            write_{{ rx }}_mon_trn(mon_trn);
         end
      end
   end

endtask : monitor_{{ rx }}


task uvma_{{ name }}_mon_vseq_c::reset_trigger();

   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ name.upper() }}_MON_VSEQ", "Mid-sim reset detected. Resetting main loop.", UVM_NONE)

endtask : reset_trigger


function logic uvma_{{ name }}_mon_vseq_c::decode_bit(logic p, logic n);

   case ({p,n})
      2'b10  : return 1'b1;
      2'b01  : return 1'b0;
      default: return 1'bx;
   endcase

endfunction : decode_bit


function string uvma_{{ name }}_mon_vseq_c::get_direction_str(uvma_{{ name }}_direction_enum direction);

   case (direction)
      UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }} : return "{{ tx.upper() }}";
      UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }} : return "{{ rx.upper() }}";
   endcase

endfunction : get_direction_str


function bit uvma_{{ name }}_mon_vseq_c::fsm(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction);

   bit unpack_trn;
   uvma_{{ name }}_mon_fsm_enum  next_state;
   case (fsm_cntxt.state)
      UVMA_{{ name.upper() }}_MON_FSM_INIT    : next_state = fsm_init    (fsm_cntxt, direction, unpack_trn);
      UVMA_{{ name.upper() }}_MON_FSM_TRAINING: next_state = fsm_training(fsm_cntxt, direction, unpack_trn);
      UVMA_{{ name.upper() }}_MON_FSM_SYNCING : next_state = fsm_syncing (fsm_cntxt, direction, unpack_trn);
      UVMA_{{ name.upper() }}_MON_FSM_SYNCED  : next_state = fsm_synced  (fsm_cntxt, direction, unpack_trn);
      default: begin
         `uvm_error({"{{ name.upper() }}_MON_VSEQ_", get_direction_str(direction)}, $sformatf("%s - Invalid state, changing to INIT", fsm_cntxt.state.name()))
         next_state = UVMA_{{ name.upper() }}_MON_FSM_INIT;
      end
   endcase
   fsm_cntxt.state = next_state;
   cntxt.sample_cntxt_e.trigger();
   return unpack_trn;

endfunction : fsm


function void uvma_{{ name }}_mon_vseq_c::unpack_{{ tx }}_trn(output uvma_{{ name }}_mon_trn_c mon_trn);

   `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ tx.upper() }}", $sformatf("Unpacking Monitor Transaction from %0d bits", cntxt.{{ tx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
   mon_trn = uvma_{{ name }}_mon_trn_c::type_id::create("mon_trn");
   uvm_default_packer.big_endian = uvma_{{ name }}_big_endian;
   void'(mon_trn.unpack(cntxt.{{ tx }}_mon_fsm_cntxt.trn_data));
   mon_trn.set_initiator(p_sequencer);
   mon_trn.direction = UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }};
   mon_trn.cfg = cfg;
   mon_trn.set_error(!mon_trn.self_check());
   mon_trn.set_timestamp_start(cntxt.{{ tx }}_mon_fsm_cntxt.trn_start);
   mon_trn.set_timestamp_end  (cntxt.{{ tx }}_mon_fsm_cntxt.trn_end  );

endfunction : unpack_{{ tx }}_trn


function void uvma_{{ name }}_mon_vseq_c::unpack_{{ rx }}_trn(output uvma_{{ name }}_mon_trn_c mon_trn);

   `uvm_info("{{ name.upper() }}_MON_VSEQ_{{ rx.upper() }}", $sformatf("Unpacking Monitor Transaction from %0d bits", cntxt.{{ rx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
   mon_trn = uvma_{{ name }}_mon_trn_c::type_id::create("mon_trn");
   uvm_default_packer.big_endian = uvma_{{ name }}_big_endian;
   void'(mon_trn.unpack(cntxt.{{ rx }}_mon_fsm_cntxt.trn_data));
   mon_trn.set_initiator(p_sequencer);
   mon_trn.direction = UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }};
   mon_trn.cfg = cfg;
   mon_trn.set_error(!mon_trn.self_check());
   mon_trn.set_timestamp_start(cntxt.{{ rx }}_mon_fsm_cntxt.trn_start);
   mon_trn.set_timestamp_end  (cntxt.{{ rx }}_mon_fsm_cntxt.trn_end  );

endfunction : unpack_{{ rx }}_trn


function uvma_{{ name }}_mon_fsm_enum uvma_{{ name }}_mon_vseq_c::fsm_init(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   uvma_{{ name }}_mon_fsm_enum  next_state;
   string  direction_str = get_direction_str(direction);
   next_state = UVMA_{{ name.upper() }}_MON_FSM_TRAINING;
   `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - Resetting state variables", fsm_cntxt.state.name()), UVM_DEBUG)
   fsm_cntxt.reset();
   unpack_trn = 0;
   return next_state;

endfunction : fsm_init


function uvma_{{ name }}_mon_fsm_enum uvma_{{ name }}_mon_vseq_c::fsm_training(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   logic  new_bit;
   uvma_{{ name }}_mon_fsm_enum  next_state;
   string direction_str = get_direction_str(direction);
   next_state = UVMA_{{ name.upper() }}_MON_FSM_TRAINING;
   new_bit = fsm_cntxt.data_q.pop_front();
   void'(fsm_cntxt.timestamps_q.pop_front());
   if (new_bit === 0) begin
      fsm_cntxt.training_count++;
      `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - Seen %0d consecutive 1'b0", fsm_cntxt.state.name(), fsm_cntxt.training_count), UVM_DEBUG)
   end
   if (fsm_cntxt.training_count >= uvma_{{ name }}_training_length) begin
      `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - Training complete after %0d consecutive 0s", fsm_cntxt.state.name(), fsm_cntxt.training_count), UVM_LOW)
      next_state = UVMA_{{ name.upper() }}_MON_FSM_SYNCING;
   end
   unpack_trn = 0;
   return next_state;

endfunction : fsm_training


function uvma_{{ name }}_mon_fsm_enum uvma_{{ name }}_mon_vseq_c::fsm_syncing(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   uvma_{{ name }}_header_l_t    header_bits;
   uvma_{{ name }}_mon_fsm_enum  next_state;
   string direction_str = get_direction_str(direction);
   next_state = UVMA_{{ name.upper() }}_MON_FSM_SYNCING;
   if (fsm_cntxt.data_q.size() >= uvma_{{ name }}_trn_length) begin
      header_bits = {fsm_cntxt.data_q[0],fsm_cntxt.data_q[1]};
      `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - New potential header bits: %b", fsm_cntxt.state.name(), header_bits), UVM_DEBUG)
      if (header_bits == UVMA_{{ name.upper() }}_HEADER_IDLE) begin
         fsm_cntxt.num_consecutive_edges++;
         `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - New valid header bits: %b. #%0d/%0d consecutive observed", fsm_cntxt.state.name(), header_bits, fsm_cntxt.num_consecutive_edges, uvma_{{ name }}_syncing_length), UVM_DEBUG)
         if (fsm_cntxt.num_consecutive_edges >= uvma_{{ name }}_syncing_length) begin
            next_state = UVMA_{{ name.upper() }}_MON_FSM_SYNCED;
            `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("Synced to bitstream after %0d consecutive headers at %0d-bit intervals", fsm_cntxt.num_consecutive_edges, uvma_{{ name }}_trn_length), UVM_LOW)
         end
         // Dump entire potentially valid frames until we're fully synced
         repeat (uvma_{{ name }}_trn_length) begin
            void'(fsm_cntxt.data_q      .pop_front());
            void'(fsm_cntxt.timestamps_q.pop_front());
         end
      end
      else begin
         // Still hunting for that first edge of many
         fsm_cntxt.num_consecutive_edges = 0;
         void'(fsm_cntxt.data_q      .pop_front());
         void'(fsm_cntxt.timestamps_q.pop_front());
      end
   end
   unpack_trn = 0;
   return next_state;

endfunction : fsm_syncing


function uvma_{{ name }}_mon_fsm_enum uvma_{{ name }}_mon_vseq_c::fsm_synced(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction, output bit unpack_trn);

   uvma_{{ name }}_mon_fsm_enum  next_state;
   string direction_str = get_direction_str(direction);
   next_state = UVMA_{{ name.upper() }}_MON_FSM_SYNCED;
   if (fsm_cntxt.data_q.size() >= uvma_{{ name }}_trn_length) begin
      `uvm_info({"{{ name.upper() }}_MON_VSEQ_", direction_str}, $sformatf("%s - Have enough bits (%0d) to unpack trn", fsm_cntxt.state.name(), fsm_cntxt.data_q.size()), UVM_DEBUG)
      unpack_trn = 1;
      fsm_cntxt.trn_start = fsm_cntxt.timestamps_q[0];
      for (int unsigned ii=0; ii<uvma_{{ name }}_trn_length; ii++) begin
         fsm_cntxt.trn_data[ii] = fsm_cntxt.data_q      .pop_front();
         fsm_cntxt.trn_end      = fsm_cntxt.timestamps_q.pop_front();
      end
   end
   else begin
      unpack_trn = 0;
   end
   return next_state;

endfunction : fsm_synced


`endif // __UVMA_{{ name.upper() }}_MON_VSEQ_SV__

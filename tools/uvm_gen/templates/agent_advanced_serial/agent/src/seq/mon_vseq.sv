// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MON_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_MON_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_mon_vseq_c
 */
class uvma_{{ name }}_mon_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_mon_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_vseq");

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::body()
    */
   extern virtual task body();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::wait_for_reset_tx()
    */
   extern virtual task wait_for_reset_tx();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::monitor_tx()
    */
   extern virtual task monitor_tx();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::wait_for_reset_{{ rx }}()
    */
   extern virtual task wait_for_reset_{{ rx }}();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::monitor_{{ rx }}()
    */
   extern virtual task monitor_{{ rx }}();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::reset_trigger()
    */
   extern virtual task reset_trigger();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::diff_decode()
    */
   extern function logic diff_decode(logic p, logic n);

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::monitor_fsm()
    */
   extern virtual function bit monitor_fsm(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction);

endclass : uvma_{{ name }}_mon_vseq_c


function uvma_{{ name }}_mon_vseq_c::new(string name="uvma_{{ name }}_mon_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_mon_vseq_c::body();

   `uvm_info("{{ upper(name) }}_MON_VSEQ", "Monitor virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin : tx
            wait_for_reset_tx();
            monitor_tx       ();
         end
         begin : rx
            wait_for_reset_{{ rx }}();
            monitor_{{ rx }}       ();
         end
         begin : reset
            reset_trigger();
         end
      join_any
      disable fork;
   end

endtask : body


task uvma_{{ name }}_mon_vseq_c::wait_for_reset_tx();

   `uvm_info("{{ upper(name) }}_MON_VSEQ", "Waiting for post_reset on TX", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ upper(name) }}_MON_VSEQ", "Done waiting for post_reset on TX", UVM_HIGH)

endtask : wait_for_reset_tx


task uvma_{{ name }}_mon_vseq_c::monitor_tx();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  phy_trn;
{% else %}   uvma_{{ name }}_{{ tx }}_mon_trn_c  phy_trn;
{% endif %}   uvma_{{ name }}_mon_trn_c  mon_trn;
   bit  sample_trn;
   bit  trn_data[];

   forever begin
      get_{{ tx }}_phy_mon_trn(phy_trn);
      `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(tx) }}", $sformatf("Got Phy Monitor Transaction:\n%s", phy_trn.sprint()), UVM_DEBUG)
{% if symmetric %}      cntxt.{{ tx }}_mon_fsm_cntxt.data_q.push_back(diff_decode(phy_trn.dp, phy_trn.dn));
{% else %}      cntxt.{{ tx }}_mon_fsm_cntxt.data_q.push_back(diff_decode(phy_trn.txp, phy_trn.txn));
{% endif %}      `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(tx) }}", $sformatf("Monitor has accumulated %0d bits", cnrxt.{{ tx }}_mon_fsm_cnrxt.trn_data.size()), UVM_DEBUG)
      sample_trn = monitor_fsm(cntxt.mon_fsm_{{ tx }}_cntxt, UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }});
      if (sample_trn) begin
         `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(tx) }}", $sformatf("Unpacking Monitor Transaction from %0d bits", cntxt.{{ tx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
         mon_trn = uvma_{{ name }}_mon_trn_c::type_id::create("mon_trn");
         void'(mon_trn.unpack(cntxt.{{ tx }}_mon_fsm_cntxt.trn_data));
         `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(tx) }}", $sformatf("Unpacked Monitor Transaction:\n%s", mon_trn.sprint()), UVM_DEBUG)
         if (mon_trn.header != UVMA_{{ upper(name) }}_HEADER_IDLE) begin
            `uvml_hrtbt_owner(p_sequencer)
            write_{{ tx }}_mon_trn(mon_trn);
         end
      end
   end

endtask : monitor_tx


task uvma_{{ name }}_mon_vseq_c::wait_for_reset_{{ rx }}();

   `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", "Waiting for post_reset on RX", UVM_HIGH)
   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", "Done waiting for post_reset on RX", UVM_HIGH)

endtask : wait_for_reset_{{ rx }}


task uvma_{{ name }}_mon_vseq_c::monitor_{{ rx }}();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  phy_trn;
{% else %}   uvma_{{ name }}_{{ rx }}_mon_trn_c  phy_trn;
{% endif %}   uvma_{{ name }}_mon_trn_c  mon_trn;
   bit  sample_trn;
   bit  trn_data[];

   forever begin
      get_{{ rx }}_phy_mon_trn(phy_trn);
      `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", $sformatf("Got Phy Monitor Transaction:\n%s", phy_trn.sprint()), UVM_DEBUG)
{% if symmetric %}      cnrxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(diff_decode(phy_trn.dp, phy_trn.dn));
{% else %}      cnrxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(diff_decode(phy_trn.rx0p, phy_trn.rx0n));
      cnrxt.{{ rx }}_mon_fsm_cntxt.data_q.push_back(diff_decode(phy_trn.rx1p, phy_trn.rx1n));
{% endif %}      `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", $sformatf("Monitor has accumulated %0d bits", cnrxt.{{ rx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
      sample_trn = monitor_fsm(cnrxt.mon_fsm_{{ rx }}_cntxt, UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }});
      if (sample_trn) begin
         `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", $sformatf("Unpacking Monitor Transaction from %0d bits", cnrxt.{{ rx }}_mon_fsm_cntxt.trn_data.size()), UVM_DEBUG)
         mon_trn = uvma_{{ name }}_mon_trn_c::type_id::create("mon_trn");
         void'(mon_trn.unpack(cnrxt.{{ rx }}_mon_fsm_cntxt.trn_data));
         `uvm_info("{{ upper(name) }}_MON_VSEQ_{{ upper(rx) }}", $sformatf("Unpacked Monitor Transaction:\n%s", mon_trn.sprint()), UVM_DEBUG)
         if (mon_trn.header != UVMA_{{ upper(name) }}_HEADER_IDLE) begin
            `uvml_hrtbt_owner(p_sequencer)
            write_{{ rx }}_mon_trn(mon_trn);
         end
      end
   end

endtask : monitor_{{ rx }}


task uvma_{{ name }}_mon_vseq_c::reset_trigger();

   wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
   wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
   `uvm_info("{{ upper(name) }}_MON_VSEQ", "Mid-sim reset detected. Resetting main loop.", UVM_NONE)

endtask : reset_trigger


function logic uvma_{{ name }}_mon_vseq_c::diff_decode(logic p, logic n);

   case ({p,n})
      2'b10  : return 1'b1;
      2'b01  : return 1'b0;
      default: return 1'bx;
   endcase

endfunction : diff_decode


function bit uvma_{{ name }}_mon_vseq_c::monitor_fsm(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction);

   string       direction_str = "";
   bit          sample_trn = 0;
   logic        new_bit;
   logic [1:0]  header_bits;
   uvma_{{ name }}_mon_fsm_enum  next_state;

   case (direction)
      UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }} : direction_str = "TX";
      UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }} : direction_str = "RX";
   endcase

   case (fsm_cntxt.state)
      UVMA_{{ upper(name) }}_MON_FSM_INIT: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_TRAINING;
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - Resetting state variables", fsm_cntxt.state.name()), UVM_DEBUG)
         fsm_cntxt.reset();
      end

      UVMA_{{ upper(name) }}_MON_FSM_TRAINING: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_TRAINING;
         new_bit = fsm_cntxt.data_q.pop_front();
         if (new_bit === 0) begin
            fsm_cntxt.training_count++;
            `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - Seen %0d consecutive 1'b0", fsm_cntxt.state.name(), fsm_cntxt.training_count), UVM_DEBUG)
         end
         if (fsm_cntxt.training_count >= uvma_{{ name }}_training_length) begin
            `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - Training complete after %0d consecutive 0s", fsm_cntxt.state.name(), fsm_cntxt.training_count), UVM_DEBUG)
            next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
         end
      end

      UVMA_{{ upper(name) }}_MON_FSM_SYNCING: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCING;
         if (fsm_cntxt.data_q.size() >= 2) begin
            header_bits = {fsm_cntxt.data_q[0],fsm_cntxt.data_q[1]};
            `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - New potential header bits: %b", fsm_cntxt.state.name(), header_bits), UVM_DEBUG)
            if (header_bits inside {UVMA_{{ upper(name) }}_HEADER_DATA,UVMA_{{ upper(name) }}_HEADER_IDLE}) begin
               next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
               `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, "Synced to bitstream", UVM_LOW)
            end
            else begin
               void'(fsm_cntxt.data_q.pop_front());
            end
         end
      end

      UVMA_{{ upper(name) }}_MON_FSM_SYNCED: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
         if (fsm_cntxt.data_q.size() >= uvma_{{ name }}_trn_length) begin
            `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - Have enough bits (%0d) to unpack trn", fsm_cntxt.state.name(), fsm_cntxt.data_q.size()), UVM_DEBUG)
            sample_trn = 1;
            for (int unsigned ii = 0; ii<uvma_{{ name }}_trn_length; ii++) begin
               fsm_cntxt.trn_data[ii] = fsm_cntxt.data_q.pop_front();
            end
         end
      end

      default: begin
         `uvm_warning({"{{ upper(name) }}_MON_VSEQ_", direction_str}, $sformatf("%s - Invalid state, changing to INIT", fsm_cntxt.state.name()))
         next_state = UVMA_{{ upper(name) }}_MON_FSM_INIT;
      end
   endcase

   fsm_cntxt.state = next_state;
   return sample_trn;

endfunction : monitor_fsm


`endif // __UVMA_{{ upper(name) }}_MON_VSEQ_SV__

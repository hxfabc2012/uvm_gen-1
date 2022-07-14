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
    * TODO Describe uvma_{{ name }}_mon_vseq_c::monitor_tx()
    */
   extern virtual task monitor_tx();

   /**
    * TODO Describe uvma_{{ name }}_mon_vseq_c::monitor_rx()
    */
   extern virtual task monitor_rx();

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
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            monitor_tx();
         end

         begin : rx
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            monitor_rx();
         end

         begin : reset
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end

endtask : body


task uvma_{{ name }}_mon_vseq_c::monitor_tx();

   uvma_{{ name }}_tx_mon_trn_c  serial_trn;
   uvma_{{ name }}_mon_trn_c  frame_trn;
   bit  sample_frame;
   bit  frame_data[];

   forever begin
      get_tx_mon_trn(serial_trn);
      cntxt.mon_fsm_tx_cntxt.rx_data.push_back(serial_trn.txdp);
      sample_frame = monitor_fsm(cntxt.mon_fsm_tx_cntxt, UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }});
      if (sample_frame) begin
         frame_trn = uvma_{{ name }}_mon_trn_c::type_id::create("frame_trn");
         void'(frame_trn.unpack(cntxt.mon_fsm_tx_cntxt.rx_frame));
         if (!frame_trn.is_idle()) begin
            `uvml_hrtbt_owner(p_sequencer)
            write_mon_trn_tx(frame_trn);
         end
      end
   end

endtask : monitor_tx


task uvma_{{ name }}_mon_vseq_c::monitor_rx();

   uvma_{{ name }}_rx_mon_trn_c  serial_trn;
   uvma_{{ name }}_mon_trn_c  frame_trn;
   bit  sample_frame;

   forever begin
      get_rx_mon_trn(serial_trn);
{% if symmetric %}      cntxt.mon_fsm_rx_cntxt.rx_data.push_back(serial_trn.rxp);
{% else %}      cntxt.mon_fsm_rx_cntxt.rx_data.push_back(serial_trn.rx1p);
      cntxt.mon_fsm_rx_cntxt.rx_data.push_back(serial_trn.rx2p);
{% endif %}      sample_frame = monitor_fsm(cntxt.mon_fsm_rx_cntxt, UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }});
      if (sample_frame) begin
         frame_trn = uvma_{{ name }}_mon_trn_c::type_id::create("frame_trn");
         void'(frame_trn.unpack(cntxt.mon_fsm_rx_cntxt.rx_frame));
         if (!frame_trn.is_idle()) begin
            `uvml_hrtbt_owner(p_sequencer)
            write_mon_trn_rx(frame_trn);
         end
      end
   end

endtask : monitor_rx


function bit uvma_{{ name }}_mon_vseq_c::monitor_fsm(uvma_{{ name }}_mon_fsm_cntxt_c fsm_cntxt, uvma_{{ name }}_direction_enum direction);

   bit sample_frame;
   logic rx_bit;
   uvma_{{ name }}_frame_b_t  frame;
   uvma_{{ name }}_mon_fsm_enum next_state;

   rx_bit = fsm_cntxt.rx_data.pop_front();
   `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("received bit = %0b", rx_bit), UVM_DEBUG)

   case (fsm_cntxt.state)
      UVMA_{{ upper(name) }}_MON_FSM_INIT: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_INIT;
         sample_frame = 0;
         for (int i = 31; i > 0; i--) begin
            fsm_cntxt.rx_frame[i] = fsm_cntxt.rx_frame[i-1];
         end
         fsm_cntxt.rx_frame[0] = rx_bit;
         fsm_cntxt.startup_counter++;
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - startup_rx_count = %0d", fsm_cntxt.state.name(), fsm_cntxt.startup_counter), UVM_DEBUG)
         if (fsm_cntxt.startup_counter == 32) begin
            next_state = UVMA_{{ upper(name) }}_MON_FSM_STARTUP;
            fsm_cntxt.startup_counter = 0;
            fsm_cntxt.zero_cnt       = 0;
             `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - startup_rx_count = %0d", fsm_cntxt.state.name(), fsm_cntxt.startup_counter), UVM_DEBUG)
         end
      end

      UVMA_{{ upper(name) }}_MON_FSM_STARTUP: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_STARTUP;
         sample_frame = 0;

         if (fsm_cntxt.rx_frame[31] == 0) begin
            fsm_cntxt.zero_cnt = fsm_cntxt.zero_cnt + 1;
         end
         else begin
            fsm_cntxt.zero_cnt = 0;
         end

         for (int i = 31; i > 0; i--) begin
            fsm_cntxt.rx_frame[i] = fsm_cntxt.rx_frame[i-1];
         end
         fsm_cntxt.rx_frame[0] = rx_bit;

         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - zero_cnt = %0d", fsm_cntxt.state.name(), fsm_cntxt.zero_cnt), UVM_DEBUG)
         foreach (fsm_cntxt.rx_frame[ii]) begin
            frame[ii] = fsm_cntxt.rx_frame[ii];
         end
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - rx_frame = %b", fsm_cntxt.state.name(), frame), UVM_DEBUG)

         if (fsm_cntxt.zero_cnt >= 32) begin
            if (fsm_cntxt.rx_frame[31] == 1 && fsm_cntxt.rx_frame[30] == 0 && fsm_cntxt.rx_frame[15] == 0 && fsm_cntxt.rx_frame[14] == 1) begin
               next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
               sample_frame = 1;
               fsm_cntxt.rx_index = 0;
               `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, "SAMPLE_FRAME", UVM_DEBUG)
               `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - rx_frame = %b", fsm_cntxt.state.name(), frame), UVM_DEBUG)
            end
         end
      end

      UVMA_{{ upper(name) }}_MON_FSM_SYNCED: begin
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, "SYNCED", UVM_DEBUG)
         for (int i = 31; i > 0; i--) begin
            fsm_cntxt.rx_frame[i] = fsm_cntxt.rx_frame[i-1];
         end
         fsm_cntxt.rx_frame[0] = rx_bit;
         fsm_cntxt.rx_index = fsm_cntxt.rx_index + 1;
         next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
         sample_frame = 0;
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - rx_index = %0d", fsm_cntxt.state.name(), fsm_cntxt.rx_index), UVM_DEBUG)
         foreach (fsm_cntxt.rx_frame[ii]) begin
            frame[ii] = fsm_cntxt.rx_frame[ii];
         end
         `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - rx_frame = %b", fsm_cntxt.state.name(), frame), UVM_DEBUG)

         if (fsm_cntxt.rx_index == 32) begin
            fsm_cntxt.rx_index = 0;
            if (fsm_cntxt.rx_frame[31] == 1 && fsm_cntxt.rx_frame[30] == 0 && fsm_cntxt.rx_frame[15] == 0 && fsm_cntxt.rx_frame[14] == 1) begin
               next_state = UVMA_{{ upper(name) }}_MON_FSM_SYNCED;
               sample_frame = 1;
               `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, $sformatf("%s - rx_frame = %b", fsm_cntxt.state.name(), frame), UVM_DEBUG)
               `uvm_info({"{{ upper(name) }}_MON_VSEQ_", direction}, "SAMPLE_FRAME", UVM_DEBUG)
            end
            else begin
               next_state = UVMA_{{ upper(name) }}_MON_FSM_STARTUP;
            end
         end
      end

      default: begin
         next_state = UVMA_{{ upper(name) }}_MON_FSM_INIT; sample_frame = 0;
      end
   endcase

   fsm_cntxt.state = next_state;
   return sample_frame;

endfunction : monitor_fsm


`endif // __UVMA_{{ upper(name) }}_MON_VSEQ_SV__

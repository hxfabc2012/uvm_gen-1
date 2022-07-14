// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_IDLE_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_IDLE_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_idle_vseq_c
 */
class uvma_{{ name }}_idle_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_idle_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_idle_vseq");

   /**
    * TODO Describe uvma_{{ name }}_idle_vseq_c::body()
    */
   extern virtual task body();

   /**
    * TODO Describe uvma_{{ name }}_idle_vseq_c::do_idle_tx()
    */
   extern task do_idle_tx();

   /**
    * TODO Describe uvma_{{ name }}_idle_vseq_c::do_idle_rx()
    */
   extern task do_idle_rx();

endclass : uvma_{{ name }}_idle_vseq_c


function uvma_{{ name }}_idle_vseq_c::new(string name="uvma_{{ name }}_idle_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_idle_vseq_c::body();

   `uvm_info("{{ upper(name) }}_IDLE_VSEQ", "Idle virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_1) }}: do_idle_tx();
      UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_2) }}: do_idle_rx();
   endcase

endtask : body


task uvma_{{ name }}_idle_vseq_c::do_idle_tx();

   uvma_{{ name }}_seq_item_c  tx_idle;

   forever begin
      `uvm_create_on(tx_idle, p_sequencer.frame_sequencer)
      tx_idle.direction = UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }};
      tx_idle.q_sync    = 2'b01;
      tx_idle.i_sync    = 2'b10;
      tx_idle.q0        = 0;
      tx_idle.q_data    = 0;
      tx_idle.tx_ctrl   = 0;
      tx_idle.i_data    = 0;
      tx_idle.is_idle   = 1;
      `uvm_send_pri(tx_idle, `UVMA_{{ upper(name) }}_FRAME_IDLE_PRI)
   end

endtask : do_idle_tx


task uvma_{{ name }}_idle_vseq_c::do_idle_rx();

   uvma_{{ name }}_seq_item_c  rx_idle;

   forever begin
      `uvm_create_on(rx_idle, p_sequencer.frame_sequencer)
      rx_idle.direction = UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }};
      rx_idle.q_sync    = 2'b01;
      rx_idle.i_sync    = 2'b10;
      rx_idle.q0        = 0;
      rx_idle.q_data    = 0;
      rx_idle.tx_ctrl   = 0;
      rx_idle.i_data    = 0;
      rx_idle.is_idle   = 1;
      `uvm_send_pri(rx_idle, `UVMA_{{ upper(name) }}_FRAME_IDLE_PRI)
   end

endtask : do_idle_rx


`endif // __UVMA_{{ upper(name) }}_BASE_SEQ_SV__

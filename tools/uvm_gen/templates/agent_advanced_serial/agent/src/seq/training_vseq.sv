// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_TRAINING_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_TRAINING_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_training_vseq_c
 */
class uvma_{{ name }}_training_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_training_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_training_vseq");

   /**
    * TODO Describe uvma_{{ name }}_training_vseq_c::body()
    */
   extern virtual task body();

   /**
    * TODO Describe uvma_{{ name }}_training_vseq_c::do_training_tx()
    */
   extern task do_training_tx();

   /**
    * TODO Describe uvma_{{ name }}_training_vseq_c::do_training_rx()
    */
   extern task do_training_rx();

endclass : uvma_{{ name }}_training_vseq_c


function uvma_{{ name }}_training_vseq_c::new(string name="uvma_{{ name }}_training_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_training_vseq_c::body();

   `uvm_info("{{ upper(name) }}_TRAINING_VSEQ", "Training virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_1) }}: do_training_tx();
      UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_2) }}: do_training_rx();
   endcase

endtask : body


task uvma_{{ name }}_training_vseq_c::do_training_tx();

{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  tx_seq_item;

   repeat (32) begin
      `uvm_create_on(tx_seq_item, p_sequencer.tx_sequencer)
      `uvm_rand_send_pri_with(tx_seq_item, `UVMA_{{ upper(name) }}_TX_DRV_SEQ_ITEM_PRI, {
         dp == 0;
      })
   end
{% else %}   uvma_{{ name }}_tx_seq_item_c  tx_seq_item;

   repeat (32) begin
      `uvm_create_on(tx_seq_item, p_sequencer.tx_sequencer)
      `uvm_rand_send_pri_with(tx_seq_item, `UVMA_{{ upper(name) }}_TX_DRV_SEQ_ITEM_PRI, {
         txp == 0;
      })
   end
{% endif %}
endtask : do_training_tx


task uvma_{{ name }}_training_vseq_c::do_training_rx();

{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  rx_seq_item;

   repeat (32) begin
      `uvm_create_on(rx_seq_item, p_sequencer.rx_sequencer)
      `uvm_rand_send_pri_with(rx_seq_item, `UVMA_{{ upper(name) }}_RX_DRV_SEQ_ITEM_PRI, {
         dp == 0;
      })
   end
{% else %}   uvma_{{ name }}_rx_seq_item_c  rx_seq_item;

   repeat (16) begin
      `uvm_create_on(rx_seq_item, p_sequencer.rx_sequencer)
      `uvm_rand_send_pri_with(rx_seq_item, `UVMA_{{ upper(name) }}_RX_DRV_SEQ_ITEM_PRI, {
         rx0p == 0;
         rx1p == 0;
      })
   end
{% endif %}
endtask : do_training_rx


`endif // __UVMA_{{ upper(name) }}_BASE_SEQ_SV__

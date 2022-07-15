// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_TRAINING_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_TRAINING_VSEQ_SV__


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
    * TODO Describe uvma_{{ name }}_training_vseq_c::do_training_{{ rx }}()
    */
   extern task do_training_{{ rx }}();

endclass : uvma_{{ name }}_training_vseq_c


function uvma_{{ name }}_training_vseq_c::new(string name="uvma_{{ name }}_training_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_training_vseq_c::body();

   `uvm_info("{{ name.upper() }}_TRAINING_VSEQ", "Training virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: do_training_tx();
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: do_training_{{ rx }}();
   endcase

endtask : body


task uvma_{{ name }}_training_vseq_c::do_training_tx();

{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  {{ tx }}_seq_item;

   do begin
      `uvm_create_on({{ tx }}_seq_item, p_sequencer.{{ tx }}_sequencer)
      `uvm_rand_send_pri_with({{ tx }}_seq_item, `UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_SEQ_ITEM_PRI, {
         dp == 0;
      })
   end while (cntxt.{{ tx }}_mon_fsm_cntxt.state != UVMA_{{ name.upper() }}_MON_FSM_SYNCED);
{% else %}   uvma_{{ name }}_{{ tx }}_seq_item_c  {{ tx }}_seq_item;

   do begin
      `uvm_create_on({{ tx }}_seq_item, p_sequencer.{{ tx }}_sequencer)
      `uvm_rand_send_pri_with({{ tx }}_seq_item, `UVMA_{{ name.upper() }}_{{ tx.upper() }}_DRV_SEQ_ITEM_PRI, {
         txp == 0;
      })
   end while (cntxt.{{ tx }}_mon_fsm_cntxt.state != UVMA_{{ name.upper() }}_MON_FSM_SYNCED);
{% endif %}
endtask : do_training_tx


task uvma_{{ name }}_training_vseq_c::do_training_{{ rx }}();

{% if symmetric %}   uvma_{{ name }}_phy_seq_item_c  {{ rx }}_seq_item;

   do begin
      `uvm_create_on({{ rx }}_seq_item, p_sequencer.{{ rx }}_sequencer)
      `uvm_rand_send_pri_with({{ rx }}_seq_item, `UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_SEQ_ITEM_PRI, {
         dp == 0;
      })
   end while (cntxt.{{ rx }}_mon_fsm_cntxt.state != UVMA_{{ name.upper() }}_MON_FSM_SYNCED);
{% else %}   uvma_{{ name }}_{{ rx }}_seq_item_c  {{ rx }}_seq_item;

   do begin
      `uvm_create_on({{ rx }}_seq_item, p_sequencer.{{ rx }}_sequencer)
      `uvm_rand_send_pri_with({{ rx }}_seq_item, `UVMA_{{ name.upper() }}_{{ rx.upper() }}_DRV_SEQ_ITEM_PRI, {
         rx0p == 0;
         rx1p == 0;
      })
   end while (cntxt.{{ rx }}_mon_fsm_cntxt.state != UVMA_{{ name.upper() }}_MON_FSM_SYNCED);
{% endif %}
endtask : do_training_{{ rx }}


`endif // __UVMA_{{ name.upper() }}_TRAINING_VSEQ_SV__

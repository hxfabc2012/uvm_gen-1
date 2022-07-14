// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_BASE_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_BASE_VSEQ_SV__


/**
 * Abstract object from which all other {{ full_name }} agent sequences must extend.  Subclasses must be run on
 * {{ full_name }} Virtual Sequencer (uvma_{{ name }}_vsqr_c) instance.
 */
class uvma_{{ name }}_base_vseq_c extends uvm_sequence #(
   .REQ(uvma_{{ name }}_seq_item_c),
   .RSP(uvma_{{ name }}_seq_item_c)
);

   /// @defgroup Agent handles
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}


   `uvm_object_utils(uvma_{{ name }}_base_vseq_c)
   `uvm_declare_p_sequencer(uvma_{{ name }}_vsqr_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_base_vseq");

   /**
    * Assigns cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::upstream_get_next_item()
    */
   extern task upstream_get_next_item(ref uvm_sequence_item req);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::upstream_item_done()
    */
   extern task upstream_item_done(ref uvm_sequence_item req);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::write_mon_trn_tx()
    */
   extern task write_mon_trn_tx(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::write_mon_trn_rx()
    */
   extern task write_mon_trn_rx(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::get_tx_mon_trn()
    */
   extern task get_tx_mon_trn(output uvma_{{ name }}_tx_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::get_rx_mon_trn()
    */
   extern task get_rx_mon_trn(output uvma_{{ name }}_rx_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_rx_drv_vseq_c::wait_clk()
    */
   extern task wait_clk();

endclass : uvma_{{ name }}_base_vseq_c


function uvma_{{ name }}_base_vseq_c::new(string name="uvma_{{ name }}_base_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_base_vseq_c::pre_start();

   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;

endtask : pre_start


task uvma_{{ name }}_base_vseq_c::upstream_get_next_item(ref uvm_sequence_item req);

   p_sequencer.upstream_sqr_port.get_next_item(req);

endtask : upstream_get_next_item


task uvma_{{ name }}_base_vseq_c::upstream_item_done(ref uvm_sequence_item req);

   p_sequencer.upstream_sqr_port.item_done(req);

endtask : upstream_item_done


task uvma_{{ name }}_base_vseq_c::write_mon_trn_tx(ref uvma_{{ name }}_mon_trn_c trn);

   p_sequencer.mon_trn_tx_ap.write(trn);

endtask : write_mon_trn_tx


task uvma_{{ name }}_base_vseq_c::write_mon_trn_rx(ref uvma_{{ name }}_mon_trn_c trn);

   p_sequencer.mon_trn_rx_ap.write(trn);

endtask : write_mon_trn_rx


task uvma_{{ name }}_base_vseq_c::get_tx_mon_trn(output uvma_{{ name }}_tx_mon_trn_c trn);

   p_sequencer.tx_mon_trn_fifo.get(trn);

endtask : get_tx_mon_trn


task uvma_{{ name }}_base_vseq_c::get_rx_mon_trn(output uvma_{{ name }}_rx_mon_trn_c trn);

   p_sequencer.rx_mon_trn_fifo.get(trn);

endtask : get_rx_mon_trn


task uvma_{{ name }}_base_vseq_c::wait_clk();

{% if symmetric %}   case (cfg.drv_mode)
      UVMA_{{ upper(name) }}_DIRECTION_TX : @(cntxt.vif.drv_tx_cb);
      UVMA_{{ upper(name) }}_DIRECTION_RX : @(cntxt.vif.drv_rx_cb);
   endcase{% endif %}

endtask : wait_clk


`endif // __UVMA_{{ upper(name) }}_BASE_SEQ_SV__

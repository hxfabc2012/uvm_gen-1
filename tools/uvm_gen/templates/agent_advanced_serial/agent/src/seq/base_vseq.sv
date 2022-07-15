// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_BASE_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_BASE_VSEQ_SV__


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
    * TODO Describe uvma_{{ name }}_base_vseq_c::write_{{ tx }}_mon_trn()
    */
   extern task write_{{ tx }}_mon_trn(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::write_{{ rx }}_mon_trn()
    */
   extern task write_{{ rx }}_mon_trn(ref uvma_{{ name }}_mon_trn_c trn);

   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::get_{{ tx }}_phy_mon_trn()
    */
{% if symmetric %}   extern task get_{{ tx }}_phy_mon_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern task get_{{ tx }}_phy_mon_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   /**
    * TODO Describe uvma_{{ name }}_base_vseq_c::get_{{ rx }}_phy_mon_trn()
    */
{% if symmetric %}   extern task get_{{ rx }}_phy_mon_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern task get_{{ rx }}_phy_mon_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
   /**
    * TODO Describe uvma_{{ name }}_{{ rx }}_drv_vseq_c::wait_clk()
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


task uvma_{{ name }}_base_vseq_c::write_{{ tx }}_mon_trn(ref uvma_{{ name }}_mon_trn_c trn);

   p_sequencer.{{ tx }}_mon_trn_ap.write(trn);

endtask : write_{{ tx }}_mon_trn


task uvma_{{ name }}_base_vseq_c::write_{{ rx }}_mon_trn(ref uvma_{{ name }}_mon_trn_c trn);

   p_sequencer.{{ rx }}_mon_trn_ap.write(trn);

endtask : write_{{ rx }}_mon_trn


{% if symmetric %}task uvma_{{ name }}_base_vseq_c::get_{{ tx }}_phy_mon_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}task uvma_{{ name }}_base_vseq_c::get_{{ tx }}_phy_mon_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   p_sequencer.{{ tx }}_phy_mon_trn_fifo.get(trn);

endtask : get_{{ tx }}_phy_mon_trn


{% if symmetric %}task uvma_{{ name }}_base_vseq_c::get_{{ rx }}_phy_mon_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}task uvma_{{ name }}_base_vseq_c::get_{{ rx }}_phy_mon_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
   p_sequencer.{{ rx }}_phy_mon_trn_fifo.get(trn);

endtask : get_{{ rx }}_phy_mon_trn


task uvma_{{ name }}_base_vseq_c::wait_clk();

{% if symmetric %}   case (cfg.drv_mode)
      UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }} : @(cntxt.vif.drv_{{ tx }}_cb);
      UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }} : @(cntxt.vif.drv_{{ rx }}_cb);
   endcase{% endif %}

endtask : wait_clk


`endif // __UVMA_{{ name.upper() }}_BASE_SEQ_SV__

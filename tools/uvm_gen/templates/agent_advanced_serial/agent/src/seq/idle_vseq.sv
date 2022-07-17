// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__


/**
 * Virtual Sequence generating IDLE Sequence Items at the lowest sequencer priority possible.
 */
class uvma_{{ name }}_idle_vseq_c extends uvma_{{ name }}_base_vseq_c;

   `uvm_object_utils(uvma_{{ name }}_idle_vseq_c)

   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_idle_vseq");

   /**
    * Launches #idle_loop().
    */
   extern virtual task body();

   /**
    * Infinite loop generating IDLE Sequence Items.
    */
   extern task idle_loop();

endclass : uvma_{{ name }}_idle_vseq_c


function uvma_{{ name }}_idle_vseq_c::new(string name="uvma_{{ name }}_idle_vseq");

   super.new(name);

endfunction : new


task uvma_{{ name }}_idle_vseq_c::body();

   `uvm_info("{{ name.upper() }}_IDLE_VSEQ", "Idle virtual sequence has started", UVM_HIGH)
   idle_loop();

endtask : body


task uvma_{{ name }}_idle_vseq_c::idle_loop();

   uvma_{{ name }}_seq_item_c  idle_seq_item;
   forever begin
      `uvm_create_on(idle_seq_item, p_sequencer)
      `uvm_rand_send_pri_with(idle_seq_item, `UVMA_{{ name.upper() }}_IDLE_SEQ_ITEM_PRI, {
         header == UVMA_{{ name.upper() }}_HEADER_IDLE;
      })
   end

endtask : idle_loop


`endif // __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__
`define __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__


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
    * TODO Describe uvma_{{ name }}_idle_vseq_c::idle_loop()
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

   forever begi
      `uvm_create_on(idle_seq_item, p_sequencer)
      idle_seq_item.sync = UVMA_{{ name.upper() }}_SYNC_IDLE;
      `uvm_send_pri(idle_seq_item, `UVMA_{{ name.upper() }}_IDLE_SEQ_ITEM_PRI)
   end

endtask : idle_loop


`endif // __UVMA_{{ name.upper() }}_IDLE_VSEQ_SV__

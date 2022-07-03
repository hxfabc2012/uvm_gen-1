// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c
 */
class uvma_{{ name }}_{{ tx }}_drv_vseq_c extends uvma_{{ name }}_base_vseq_c;
   
   `uvm_object_utils(uvma_{{ name }}_{{ tx }}_drv_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ tx }}_drv_vseq");
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::post_reset_init()
    */
   extern task post_reset_init();
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::process_req()
    */
   extern function void process_req(ref uvma_{{ name }}_seq_item_c seq_item);
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::drive()
    */
   extern virtual task drive(ref uvma_{{ name }}_seq_item_c frame);
   
   /**
    * TODO Describe uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_clk()
    */
   extern task wait_clk();
   
endclass : uvma_{{ name }}_{{ tx }}_drv_vseq_c


function uvma_{{ name }}_{{ tx }}_drv_vseq_c::new(string name="uvma_{{ name }}_{{ tx }}_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::body();
   
   uvma_{{ name }}_seq_item_c  frame;
   
   forever begin
      fork
         begin
            `uvm_info("{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ", "Waiting for post_reset", UVM_DEBUG)
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            post_reset_init();
            forever begin
               `uvm_info("{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ", "Waiting for next frame", UVM_DEBUG)
               p_sequencer.frame_sequencer.get_next_item(frame);
               
               `uvm_info("{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ", {"Got next frame:\n", frame.sprint()}, UVM_DEBUG)
               process_req                  (frame);
               drive                        (frame);
               p_sequencer.seq_item_ap.write(frame);
               
               `uvm_info("{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ", {"Done with frame:\n", frame.sprint()}, UVM_DEBUG)
               p_sequencer.frame_sequencer.item_done();
            end
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::post_reset_init();
   
   uvma_{{ name }}_{{ tx }}_seq_item_c  {{ tx }}_seq_item;
   
   repeat (64) begin
      `uvm_create_on({{ tx }}_seq_item, p_sequencer.{{ tx }}_serial_sequencer)
      `uvm_rand_send_pri_with({{ tx }}_seq_item, `UVMA_{{ upper(name) }}_{{ upper(tx) }}_DRV_SEQ_ITEM_PRI, {
         txdp == 0;
      })
   end
   
endtask : post_reset_init


function void uvma_{{ name }}_{{ tx }}_drv_vseq_c::process_req(ref uvma_{{ name }}_seq_item_c seq_item);
   
   seq_item.cfg       = cfg;
   seq_item.direction = UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }};
   `uvm_info("{{ upper(name) }}_{{ upper(tx) }}_DRV_VSEQ", $sformatf("Got item:\n%s", seq_item.sprint()), UVM_DEBUG)
   if (!seq_item.is_idle) begin
      `uvml_hrtbt_owner(p_sequencer)
   end
   
endfunction : process_req


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::drive(ref uvma_{{ name }}_seq_item_c frame);

   uvma_{{ name }}_{{ tx }}_seq_item_c   {{ tx }}_seq_item;
   bit                         frame_bits[];
   int unsigned                num_frame_bits;
   
   uvm_default_packer.big_endian = 0;
   num_frame_bits = frame.pack(frame_bits);
   for (int ii=num_frame_bits-1; ii>=0; ii--) begin
      
      `uvm_create_on({{ tx }}_seq_item, p_sequencer.{{ tx }}_serial_sequencer)
      `uvm_rand_send_pri_with({{ tx }}_seq_item, `UVMA_{{ upper(name) }}_{{ upper(tx) }}_DRV_SEQ_ITEM_PRI, {
         txdp == frame_bits[ii];
      })
   end
   
endtask : drive


task uvma_{{ name }}_{{ tx }}_drv_vseq_c::wait_clk();
   
   @(cntxt.vif.drv_{{ tx }}_cb);
   
endtask : wait_clk


`endif // __UVMA_{{ upper(name) }}_BASE_SEQ_SV__

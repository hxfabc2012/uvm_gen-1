// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MSTR_DRV_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_MSTR_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c
 */
class uvma_{{ name }}_mstr_drv_vseq_c extends uvma_{{ name }}_base_vseq_c;
   
   `uvm_object_utils(uvma_{{ name }}_mstr_drv_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mstr_drv_vseq");
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c::process_req()
    */
   extern function void process_req(ref uvma_{{ name }}_seq_item_c seq_item);
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c::drive()
    */
   extern virtual task drive(ref uvma_{{ name }}_seq_item_c seq_item);
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c::wait_clk_a()
    */
   extern task wait_clk_a();
   
   /**
    * TODO Describe uvma_{{ name }}_mstr_drv_vseq_c::wait_clk_r()
    */
   extern task wait_clk_r();
   
endclass : uvma_{{ name }}_mstr_drv_vseq_c


function uvma_{{ name }}_mstr_drv_vseq_c::new(string name="uvma_{{ name }}_mstr_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_{{ name }}_mstr_drv_vseq_c::body();
   
   uvma_{{ name }}_seq_item_c  seq_item;
   
   forever begin
      fork
         begin
            `uvm_info("{{ upper(name) }}_MSTR_DRV_VSEQ", "Waiting for post_reset", UVM_DEBUG)
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
               `uvm_info("{{ upper(name) }}_MSTR_DRV_VSEQ", "Waiting for next item", UVM_DEBUG)
               p_sequencer.get_next_item    (seq_item);
               `uvm_info("{{ upper(name) }}_MSTR_DRV_VSEQ", {"Got next item:\n", seq_item.sprint()}, UVM_DEBUG)
               process_req                  (seq_item);
               drive                        (seq_item);
               p_sequencer.seq_item_ap.write(seq_item);
               p_sequencer.item_done();
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


function void uvma_{{ name }}_mstr_drv_vseq_c::process_req(ref uvma_{{ name }}_seq_item_c seq_item);
   
   seq_item.cfg = cfg;
   `uvm_info("{{ upper(name) }}_MSTR_DRV_VSEQ", $sformatf("Got item:\n%s", seq_item.sprint()), UVM_HIGH)
   `uvml_hrtbt_owner(p_sequencer)
   
endfunction : process_req


task uvma_{{ name }}_mstr_drv_vseq_c::drive(ref uvma_{{ name }}_seq_item_c seq_item);

   uvma_{{ name }}_mstr_a_seq_item_c  mstr_a_seq_item;
   uvma_{{ name }}_mstr_r_seq_item_c  mstr_r_seq_item;
   
   // TODO Implement latencies
   // TODO Add ton/toff
   do begin
      `uvm_create_on(mstr_a_seq_item, p_sequencer.mstr_a_sequencer)
      `uvm_rand_send_pri_with(mstr_a_seq_item, `UVMA_{{ upper(name) }}_MSTR_DRV_SEQ_ITEM_PRI, {
         req     == 1'b1;
         addr    == seq_item.address    ;
         we      == seq_item.access_type;
         be      == seq_item.be         ;
         wdata   == seq_item.data       ;
         auser   == seq_item.auser      ;
         wuser   == seq_item.wuser      ;
         aid     == seq_item.id         ;
         atop    == seq_item.atop       ;
         memtype == seq_item.memtype    ;
         prot    == seq_item.prot       ;
      })
   end while (mstr_a_seq_item.gnt !== 1'b1);
   
   do begin
      `uvm_create_on(mstr_r_seq_item, p_sequencer.mstr_r_sequencer)
      `uvm_rand_send_pri_with(mstr_r_seq_item, `UVMA_{{ upper(name) }}_MSTR_DRV_SEQ_ITEM_PRI, {
         rready == 1'b1;
      })
   end while(mstr_r_seq_item.rvalid !== 1'b1);
   
   if (seq_item.access_type == UVMA_{{ upper(name) }}_ACCESS_READ) begin
      seq_item.data = mstr_r_seq_item.rdata;
   end
   
endtask : drive


task uvma_{{ name }}_mstr_drv_vseq_c::wait_clk_a();
   
   @(cntxt.vif.drv_mstr_a_cb);
   
endtask : wait_clk_a


task uvma_{{ name }}_mstr_drv_vseq_c::wait_clk_r();
   
   @(cntxt.vif.drv_mstr_r_cb);
   
endtask : wait_clk_r


`endif // __UVMA_{{ upper(name) }}_BASE_SEQ_SV__

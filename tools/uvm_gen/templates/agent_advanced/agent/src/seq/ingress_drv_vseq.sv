// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_${name_uppercase}_SLV_DRV_VSEQ_SV__
`define __UVMA_${name_uppercase}_SLV_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_${name}_slv_drv_vseq_c
 */
class uvma_${name}_slv_drv_vseq_c extends uvma_${name}_base_vseq_c;
   
   `uvm_object_utils(uvma_${name}_slv_drv_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_slv_drv_vseq");
   
   /**
    * TODO Describe uvma_${name}_slv_drv_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_${name}_slv_drv_vseq_c::drive_a()
    */
   extern virtual task drive_a();
   
   /**
    * TODO Describe uvma_${name}_slv_drv_vseq_c::response_loop()
    */
   extern virtual task response_loop();
   
   /**
    * TODO Describe uvma_${name}_slv_base_vseq_c::wait_clk_a()
    */
   extern task wait_clk_a();
   
   /**
    * TODO Describe uvma_${name}_slv_base_vseq_c::wait_clk_r()
    */
   extern task wait_clk_r();
   
endclass : uvma_${name}_slv_drv_vseq_c


function uvma_${name}_slv_drv_vseq_c::new(string name="uvma_${name}_slv_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_${name}_slv_drv_vseq_c::body();
   
   forever begin
      fork
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
               drive_a();
            end
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
               response_loop();
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


task uvma_${name}_slv_drv_vseq_c::drive_a();
   
   uvma_${name}_slv_a_seq_item_c  slv_a_seq_item;
   
   forever begin
      // TODO Add ton/toff
      if ($urandom_range(0,1)) begin
         `uvm_create_on(slv_a_seq_item, p_sequencer.slv_a_sequencer)
         `uvm_rand_send_pri_with(slv_a_seq_item, `UVMA_${name_uppercase}_SLV_DRV_SEQ_ITEM_PRI, {
            gnt == 1'b1;
         })
      end
      else begin
         wait_clk_a();
      end
   end
   
endtask : drive_a


task uvma_${name}_slv_drv_vseq_c::response_loop();
   
   uvma_${name}_mstr_a_mon_trn_c  trn        ;
   bit                        handled = 0;
   
   forever begin
      cntxt.mstr_a_req_e.wait_trigger();
      while (cntxt.drv_slv_outstanding_q.size()) begin
         trn = cntxt.drv_slv_outstanding_q.pop_front();
         handled = 0;
         foreach (cntxt.slv_handlers[jj]) begin
            cntxt.slv_handlers[jj].handle_mstr_req(trn, handled);
            if (handled) begin
               break;
            end
         end
         if (!handled) begin
            `uvm_warning("${name_uppercase}_SLV_DRV_VSEQ", $sformatf("Request from MSTR not handled:\n%s", trn.sprint()))
         end
      end
   end
   
endtask : response_loop


task uvma_${name}_slv_drv_vseq_c::wait_clk_a();
   
   @(cntxt.vif.drv_slv_a_cb);
   
endtask : wait_clk_a


task uvma_${name}_slv_drv_vseq_c::wait_clk_r();
   
   @(cntxt.vif.drv_slv_r_cb);
   
endtask : wait_clk_r


`endif // __UVMA_${name_uppercase}_BASE_SEQ_SV__

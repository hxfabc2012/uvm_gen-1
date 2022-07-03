// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_IDLE_VSEQ_SV__
`define __UVMA_OBI_IDLE_VSEQ_SV__


/**
 * TODO Describe uvma_obi_idle_vseq_c
 */
class uvma_obi_idle_vseq_c extends uvma_obi_base_vseq_c;
   
   `uvm_object_utils(uvma_obi_idle_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_obi_idle_vseq");
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_mstr()
    */
   extern task do_idle_mstr();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_slv()
    */
   extern task do_idle_slv();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_mstr_a()
    */
   extern task do_idle_mstr_a();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_mstr_r()
    */
   extern task do_idle_mstr_r();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_slv_a()
    */
   extern task do_idle_slv_a();
   
   /**
    * TODO Describe uvma_obi_idle_vseq_c::do_idle_slv_r()
    */
   extern task do_idle_slv_r();
   
endclass : uvma_obi_idle_vseq_c


function uvma_obi_idle_vseq_c::new(string name="uvma_obi_idle_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_obi_idle_vseq_c::body();
   
   `uvm_info("OBI_IDLE_VSEQ", "Idle virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_OBI_DRV_MODE_MSTR: do_idle_mstr();
      UVMA_OBI_DRV_MODE_SLV : do_idle_slv ();
   endcase
   
endtask : body


task uvma_obi_idle_vseq_c::do_idle_mstr();
   
   fork
      begin : chan_a
         forever begin
            do_idle_mstr_a();
         end
      end
      
      begin : chan_r
         forever begin
            do_idle_mstr_r();
         end
      end
   join
   
endtask : do_idle_mstr


task uvma_obi_idle_vseq_c::do_idle_slv();
   
   fork
      begin : chan_a
         forever begin
            do_idle_slv_a();
         end
      end
      
      begin : chan_r
         forever begin
            do_idle_slv_r();
         end
      end
   join
   
endtask : do_idle_slv


task uvma_obi_idle_vseq_c::do_idle_mstr_a();
   
   uvma_obi_mstr_a_seq_item_c  mstr_a_seq_item;
   
   `uvm_create_on(mstr_a_seq_item, p_sequencer.mstr_a_sequencer)
   case (cfg.drv_idle)
      UVMA_OBI_DRV_IDLE_ZEROS: begin
         `uvm_rand_send_pri_with(mstr_a_seq_item, `UVMA_OBI_MSTR_A_IDLE_SEQ_ITEM_PRI, {
            req     == 0;
            addr    == 0;
            we      == 0;
            be      == 0;
            wdata   == 0;
            auser   == 0;
            wuser   == 0;
            aid     == 0;
            atop    == 0;
            memtype == 0;
            prot    == 0;
            achk    == 0;
         })
      end
      
      UVMA_OBI_DRV_IDLE_RANDOM: begin
         `uvm_rand_send_pri_with(mstr_a_seq_item, `UVMA_OBI_MSTR_A_IDLE_SEQ_ITEM_PRI, {
            req == 0;
         })
      end
   endcase
   
endtask : do_idle_mstr_a


task uvma_obi_idle_vseq_c::do_idle_mstr_r();
   
   uvma_obi_mstr_r_seq_item_c  mstr_r_seq_item;
   
   `uvm_create_on(mstr_r_seq_item, p_sequencer.mstr_r_sequencer)
   `uvm_rand_send_pri_with(mstr_r_seq_item, `UVMA_OBI_MSTR_R_IDLE_SEQ_ITEM_PRI, {
      rready == 0;
   })
   
endtask : do_idle_mstr_r


task uvma_obi_idle_vseq_c::do_idle_slv_a();
   
   uvma_obi_slv_a_seq_item_c  slv_a_seq_item;
   
   `uvm_create_on(slv_a_seq_item, p_sequencer.slv_a_sequencer)
   `uvm_rand_send_pri_with(slv_a_seq_item, `UVMA_OBI_SLV_A_IDLE_SEQ_ITEM_PRI, {
      gnt == 0;
   })
   
endtask : do_idle_slv_a


task uvma_obi_idle_vseq_c::do_idle_slv_r();
   
   uvma_obi_slv_r_seq_item_c  slv_r_seq_item;
   
   `uvm_create_on(slv_r_seq_item, p_sequencer.slv_r_sequencer)
   case (cfg.drv_idle)
      UVMA_OBI_DRV_IDLE_ZEROS: begin
         `uvm_rand_send_pri_with(slv_r_seq_item, `UVMA_OBI_SLV_R_IDLE_SEQ_ITEM_PRI, {
            rvalid    == 0;
            rdata     == 0;
            err       == 0;
            ruser     == 0;
            rid       == 0;
            exokay    == 0;
            rchk      == 0;
         })
      end
      
      UVMA_OBI_DRV_IDLE_RANDOM: begin
         `uvm_rand_send_pri_with(slv_r_seq_item, `UVMA_OBI_SLV_R_IDLE_SEQ_ITEM_PRI, {
            rvalid == 0;
         })
      end
   endcase
   
endtask : do_idle_slv_r


`endif // __UVMA_OBI_BASE_SEQ_SV__

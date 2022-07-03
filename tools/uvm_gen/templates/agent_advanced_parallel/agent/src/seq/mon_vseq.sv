// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_MON_VSEQ_SV__
`define __UVMA_OBI_MON_VSEQ_SV__


/**
 * TODO Describe uvma_obi_mon_vseq_c
 */
class uvma_obi_mon_vseq_c extends uvma_obi_base_vseq_c;
   
   `uvm_object_utils(uvma_obi_mon_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_obi_mon_vseq");
   
   /**
    * TODO Describe uvma_obi_mon_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_obi_mon_vseq_c::monitor_a()
    */
   extern virtual task monitor_a();
   
   /**
    * TODO Describe uvma_obi_mon_vseq_c::monitor_r()
    */
   extern virtual task monitor_r();
   
endclass : uvma_obi_mon_vseq_c


function uvma_obi_mon_vseq_c::new(string name="uvma_obi_mon_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_obi_mon_vseq_c::body();
   
   `uvm_info("OBI_MON_VSEQ", "Monitor virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            monitor_a();
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            monitor_r();
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


task uvma_obi_mon_vseq_c::monitor_a();
   
   uvma_obi_mstr_a_mon_trn_c  mstr_a_mon_trn, mstr_a_mon_trn_copy;
   uvma_obi_slv_a_mon_trn_c   slv_a_mon_trn ;
   
   forever begin
      do begin
         get_mstr_a_mon_trn(mstr_a_mon_trn);
         get_slv_a_mon_trn (slv_a_mon_trn );
      end while ((mstr_a_mon_trn.req !== 1'b1) || (slv_a_mon_trn.gnt !== 1'b1));
      
      cntxt.mon_outstanding_q.push_back(mstr_a_mon_trn);
      if (cfg.is_active && (cfg.drv_mode == UVMA_OBI_DRV_MODE_SLV)) begin
         mstr_a_mon_trn_copy = uvma_obi_mstr_a_mon_trn_c::type_id::create("mstr_a_mon_trn_copy");
         mstr_a_mon_trn_copy.copy(mstr_a_mon_trn);
         cntxt.drv_slv_outstanding_q.push_back(mstr_a_mon_trn);
      end
      
      do begin
         get_mstr_a_mon_trn(mstr_a_mon_trn);
         get_slv_a_mon_trn (slv_a_mon_trn );
      end while ((mstr_a_mon_trn.req === 1'b1) && (slv_a_mon_trn.gnt === 1'b1));
      
      if (cfg.is_active && (cfg.drv_mode == UVMA_OBI_DRV_MODE_SLV)) begin
         cntxt.mstr_a_req_e.trigger();
      end
      `uvml_hrtbt_owner(p_sequencer)
   end
   
endtask : monitor_a


task uvma_obi_mon_vseq_c::monitor_r();
   
   uvma_obi_mon_trn_c         mon_trn       ;
   uvma_obi_mstr_a_mon_trn_c  mstr_a_mon_trn;
   uvma_obi_mstr_r_mon_trn_c  mstr_r_mon_trn;
   uvma_obi_slv_r_mon_trn_c   slv_r_mon_trn ;
   
   forever begin
      do begin
         get_slv_r_mon_trn (slv_r_mon_trn );
         get_mstr_r_mon_trn(mstr_r_mon_trn);
      end while (((slv_r_mon_trn.rvalid !== 1'b1)) || (mstr_r_mon_trn.rready !== 1'b1));
      
      mstr_a_mon_trn = cntxt.mon_outstanding_q.pop_front();
      if (mstr_a_mon_trn != null) begin
         mon_trn = uvma_obi_mon_trn_c::type_id::create("mon_trn");
         mon_trn.set_initiator(mstr_a_mon_trn.get_initiator());
         mon_trn.cfg         = cfg;
         mon_trn.set_timestamp_start(mstr_a_mon_trn.get_timestamp_start());
         mon_trn.set_timestamp_end  (slv_r_mon_trn .get_timestamp_end  ());
         mon_trn.address     = mstr_a_mon_trn.addr   ;
         mon_trn.be          = mstr_a_mon_trn.be     ;
         mon_trn.auser       = mstr_a_mon_trn.auser  ;
         mon_trn.wuser       = mstr_a_mon_trn.wuser  ;
         mon_trn.ruser       = slv_r_mon_trn.ruser   ;
         mon_trn.aid         = mstr_a_mon_trn.aid    ;
         mon_trn.rid         = slv_r_mon_trn.rid     ;
         mon_trn.err         = slv_r_mon_trn.err     ;
         mon_trn.exokay      = slv_r_mon_trn.exokay  ;
         mon_trn.atop        = mstr_a_mon_trn.atop   ;
         mon_trn.memtype     = mstr_a_mon_trn.memtype;
         mon_trn.prot        = mstr_a_mon_trn.prot   ;
         mon_trn.achk        = mstr_a_mon_trn.achk   ;
         mon_trn.rchk        = slv_r_mon_trn.rchk    ;
         // TODO Do more protocol checks!
         
         if (mstr_a_mon_trn.we) begin
            mon_trn.data = mstr_a_mon_trn.wdata;
            mon_trn.access_type = UVMA_OBI_ACCESS_WRITE;
         end
         else begin
            mon_trn.data = slv_r_mon_trn.rdata;
            mon_trn.access_type = UVMA_OBI_ACCESS_READ;
         end
         // TODO Implement latency stats collection
      end
      else begin
         `uvm_error("OBI_MON_VSEQ", $sformatf("No outstanding mstr_a transaction to account for this slv_r transaction:\n%s", slv_r_mon_trn.sprint()))
         // TODO Handle errors
      end
      
      `uvml_hrtbt_owner(p_sequencer)
      write_mon_trn(mon_trn);
   end
   
endtask : monitor_r


`endif // __UVMA_OBI_BASE_SEQ_SV__

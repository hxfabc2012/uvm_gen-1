// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SLV_HANDLER_MEM_VSEQ_SV__
`define __UVMA_{{ upper(name) }}_SLV_HANDLER_MEM_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_slv_handler_mem_vseq_c
 */
class uvma_{{ name }}_slv_handler_mem_vseq_c extends uvma_{{ name }}_slv_handler_base_vseq_c;
   
   `uvm_object_utils(uvma_{{ name }}_slv_handler_mem_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_slv_handler_mem_vseq");
   
   /**
    * TODO Describe uvma_{{ name }}_slv_handler_mem_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_{{ name }}_slv_handler_mem_vseq_c::body()
    */
   extern virtual task handle_mstr_req(ref uvma_{{ name }}_mstr_a_mon_trn_c trn, bit handled);
   
endclass : uvma_{{ name }}_slv_handler_mem_vseq_c


function uvma_{{ name }}_slv_handler_mem_vseq_c::new(string name="uvma_{{ name }}_slv_handler_mem_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_{{ name }}_slv_handler_mem_vseq_c::body();
   
   p_sequencer.cntxt.slv_handlers.push_back(this);
   forever begin
      wait_clk();
   end
   
endtask : body


task uvma_{{ name }}_slv_handler_mem_vseq_c::handle_mstr_req(ref uvma_{{ name }}_mstr_a_mon_trn_c trn, bit handled);
   
   uvma_{{ name }}_data_b_t          readback_data ;
   uvma_{{ name }}_slv_r_seq_item_c  slv_r_seq_item;
   
   // TODO Add response latency cycles
   
   `uvm_info("{{ upper(name) }}_SLV_MEM_VSEQ", $sformatf("Responding to \n%s", trn.sprint()), UVM_DEBUG)
   do begin
      `uvm_create_on(slv_r_seq_item, p_sequencer.slv_r_sequencer)
      
      if (trn.we === 1'b1) begin
         mem_write(trn.addr, trn.wdata, trn.be);
         slv_r_seq_item.rvalid = 1'b1;
         slv_r_seq_item.err    = 1'b0;
         slv_r_seq_item.ruser  = trn.auser;
         slv_r_seq_item.rid    = trn.aid;
         // TODO Implement exokay
         // TODO Implement rchk
      end
      else begin
         readback_data = mem_read(trn.addr, trn.be);
         slv_r_seq_item.rvalid = 1'b1;
         slv_r_seq_item.rdata  = readback_data;
         slv_r_seq_item.err    = 1'b0;
         slv_r_seq_item.ruser  = trn.auser;
         slv_r_seq_item.rid    = trn.aid;
         // TODO Implement exokay
         // TODO Implement rchk
      end
      
      `uvm_send_pri(slv_r_seq_item, `UVMA_{{ upper(name) }}_SLV_DRV_SEQ_ITEM_PRI)
   end while (slv_r_seq_item.rready !== 1'b1);
   `uvm_info("{{ upper(name) }}_SLV_MEM_VSEQ", $sformatf("Responded to \n%s\nwith\n%s", trn.sprint(), slv_r_seq_item.sprint()), UVM_DEBUG)
   
   handled = 1;
   
endtask : handle_mstr_req


`endif // __UVMA_{{ upper(name) }}_SLV_HANDLER_MEM_VSEQ_SV__

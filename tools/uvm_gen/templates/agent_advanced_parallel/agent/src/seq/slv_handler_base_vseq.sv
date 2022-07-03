// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_SLV_HANDLER_BASE_VSEQ_SV__
`define __UVMA_OBI_SLV_HANDLER_BASE_VSEQ_SV__


/**
 * TODO Describe uvma_obi_slv_handler_base_vseq_c
 */
class uvma_obi_slv_handler_base_vseq_c extends uvma_obi_base_vseq_c;
   
   `uvm_object_utils(uvma_obi_slv_handler_base_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_obi_slv_handler_base_vseq");
   
   /**
    * TODO Describe uvma_obi_slv_handler_base_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_obi_slv_handler_base_vseq_c::handle_mstr_req()
    */
   extern virtual task handle_mstr_req(ref uvma_obi_mstr_a_mon_trn_c trn, bit handled);
   
   /**
    * TODO Describe uvma_obi_slv_handler_base_vseq_c::mem_read()
    */
   extern function uvma_obi_data_b_t mem_read(uvma_obi_addr_b_t address, uvma_obi_be_b_t be);
   
   /**
    * TODO Describe uvma_obi_slv_handler_base_vseq_c::mem_write()
    */
   extern function void mem_write(uvma_obi_addr_b_t address, uvma_obi_data_b_t data, uvma_obi_be_b_t be);
   
   /**
    * TODO Describe uvma_obi_slv_handler_base_vseq_c::wait_clk()
    */
   extern task wait_clk();
   
endclass : uvma_obi_slv_handler_base_vseq_c


function uvma_obi_slv_handler_base_vseq_c::new(string name="uvma_obi_slv_handler_base_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_obi_slv_handler_base_vseq_c::body();
   
   p_sequencer.cntxt.slv_handlers.push_front(this);
   forever begin
      wait_clk();
   end
   
endtask : body


task uvma_obi_slv_handler_base_vseq_c::handle_mstr_req(ref uvma_obi_mstr_a_mon_trn_c trn, bit handled);
   
   // Default behavior does nothing
   
endtask : handle_mstr_req


function uvma_obi_data_b_t uvma_obi_slv_handler_base_vseq_c::mem_read(uvma_obi_addr_b_t address, uvma_obi_be_b_t be);
   
   bit [7:0]  current_byte;
   
   for (int unsigned ii=0; ii<(cfg.data_width/8); ii++) begin
      if (be[ii]) begin
         current_byte = cntxt.memory.read(address+ii);
         for (int unsigned jj=0; jj<8; jj++) begin
            mem_read[(ii*8)+jj] = current_byte[jj];
         end
      end
   end
   
endfunction : mem_read


function void uvma_obi_slv_handler_base_vseq_c::mem_write(uvma_obi_addr_b_t address, uvma_obi_data_b_t data, uvma_obi_be_b_t be);
   
   bit [7:0]  current_byte;
   
   for (int unsigned ii=0; ii<(cfg.data_width/8); ii++) begin
      current_byte = 0;
      if (be[ii]) begin
         for (int unsigned jj=0; jj<8; jj++) begin
            current_byte[jj] = data[(ii*8)+jj];
         end
         cntxt.memory.write(address+ii, current_byte);
      end
   end
   
endfunction : mem_write


task uvma_obi_slv_handler_base_vseq_c::wait_clk();
   
   @(cntxt.vif.drv_slv_r_cb);
   
endtask : wait_clk


`endif // __UVMA_OBI_SLV_HANDLER_BASE_VSEQ_SV__

// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_OBI_ST_PRINT_VSEQ_SV__
`define __UVME_OBI_ST_PRINT_VSEQ_SV__


/**
 * TODO Describe uvme_obi_st_print_vseq_c
 */
class uvme_obi_st_print_vseq_c extends uvme_obi_st_base_vseq_c;
   
   rand uvma_obi_addr_b_t  print_location; ///< 
   
   
   `uvm_object_utils(uvme_obi_st_print_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_obi_st_print_vseq");
   
   /**
    * TODO Describe uvme_obi_st_print_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_obi_st_print_vseq_c


function uvme_obi_st_print_vseq_c::new(string name="uvme_obi_st_print_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_obi_st_print_vseq_c::body();
   
   uvma_obi_slv_handler_print_vseq_c  print_handler_vseq;
   uvma_obi_seq_item_c                write_req;
   
   fork
      begin : mstr
         #100ns;
         `uvm_create_on(write_req, p_sequencer.mstr_vsequencer);
         write_req.access_type = UVMA_OBI_ACCESS_WRITE;
         write_req.address     = print_location;
         write_req.data        = uvma_obi_data_b_t'("Hi!!");
         `uvm_send(write_req)
         #100ns;
      end
      
      begin : slv
         `uvm_create_on(print_handler_vseq, p_sequencer.mstr_vsequencer)
         print_handler_vseq.print_location = print_location;
         `uvm_send(print_handler_vseq)
      end
   join_any
   disable fork;
   
endtask : body


`endif // __UVME_OBI_ST_PRINT_VSEQ_SV__

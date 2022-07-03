// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_PRINT_VSEQ_SV__
`define __UVME_{{ upper(name) }}_ST_PRINT_VSEQ_SV__


/**
 * TODO Describe uvme_{{ name }}_st_print_vseq_c
 */
class uvme_{{ name }}_st_print_vseq_c extends uvme_{{ name }}_st_base_vseq_c;
   
   rand uvma_{{ name }}_addr_b_t  print_location; ///< 
   
   
   `uvm_object_utils(uvme_{{ name }}_st_print_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_print_vseq");
   
   /**
    * TODO Describe uvme_{{ name }}_st_print_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_{{ name }}_st_print_vseq_c


function uvme_{{ name }}_st_print_vseq_c::new(string name="uvme_{{ name }}_st_print_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_{{ name }}_st_print_vseq_c::body();
   
   uvma_{{ name }}_slv_handler_print_vseq_c  print_handler_vseq;
   uvma_{{ name }}_seq_item_c                write_req;
   
   fork
      begin : mstr
         #100ns;
         `uvm_create_on(write_req, p_sequencer.mstr_vsequencer);
         write_req.access_type = UVMA_{{ upper(name) }}_ACCESS_WRITE;
         write_req.address     = print_location;
         write_req.data        = uvma_{{ name }}_data_b_t'("Hi!!");
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


`endif // __UVME_{{ upper(name) }}_ST_PRINT_VSEQ_SV__

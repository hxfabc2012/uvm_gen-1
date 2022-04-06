// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_{{ name_uppercase }}_RAND_ACCESS_VSEQ_SV__
`define __UVMA_{{ name_uppercase }}_RAND_ACCESS_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_rand_access_vseq_c
 */
class uvma_{{ name }}_rand_access_vseq_c extends uvma_{{ name }}_base_vseq_c;
   
   rand int unsigned  num_access; ///< 
   rand int unsigned  pct_reads ; ///< 
   rand int unsigned  pct_writes; ///< 
   rand int unsigned  min_gap   ; ///< 
   rand int unsigned  max_gap   ; ///< 
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_rand_access_vseq_c)
      `uvm_field_int(num_access, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(pct_reads , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(pct_writes, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_gap   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_gap   , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      pct_reads + pct_writes == 100;
      num_access <= 100;
      min_gap <= max_gap;
      max_gap <= 25;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_rand_access_vseq");
   
   /**
    * TODO Describe uvma_{{ name }}_rand_access_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvma_{{ name }}_rand_access_vseq_c


function uvma_{{ name }}_rand_access_vseq_c::new(string name="uvma_{{ name }}_rand_access_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_{{ name }}_rand_access_vseq_c::body();
   
   uvma_{{ name }}_seq_item_c  req;
   
   for (int unsigned ii=0; ii<num_access; ii++) begin
      `uvm_create_on(req, p_sequencer)
      
      if ($urandom_range(0,100) > pct_reads) begin
         `uvm_rand_send_with(req, {
            access_type == UVMA_{{ name_uppercase }}_ACCESS_WRITE;
         })
      end
      else begin
         `uvm_rand_send_with(req, {
            access_type == UVMA_{{ name_uppercase }}_ACCESS_READ;
         })
      end
      
      repeat ($urandom_range(min_gap, max_gap)) begin
         @(cntxt.vif.mon_a_cb);
      end
   end
   
endtask : body


`endif // __UVMA_{{ name_uppercase }}_RAND_ACCESS_VSEQ_SV__

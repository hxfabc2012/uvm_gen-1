// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_ALL_ACCESS_VSEQ_SV__
`define __UVME_{{ upper(name) }}_ST_ALL_ACCESS_VSEQ_SV__


/**
 * TODO Describe uvme_{{ name }}_st_all_access_vseq_c
 */
class uvme_{{ name }}_st_all_access_vseq_c extends uvme_{{ name }}_st_base_vseq_c;
   
   rand int unsigned  num_all_access;
   
   
   `uvm_object_utils_begin(uvme_{{ name }}_st_all_access_vseq_c)
      `uvm_field_int(num_all_access, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft num_all_access == 10;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_all_access_vseq");
   
   /**
    * TODO Describe uvme_{{ name }}_st_all_access_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_{{ name }}_st_all_access_vseq_c


function uvme_{{ name }}_st_all_access_vseq_c::new(string name="uvme_{{ name }}_st_all_access_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_{{ name }}_st_all_access_vseq_c::body();
   
   uvma_{{ name }}_seq_item_c  _req;
   
   repeat (num_all_access) begin
      `uvm_do_on(_req, p_sequencer.mstr_vsequencer)
   end
   
endtask : body


`endif // __UVME_{{ upper(name) }}_ST_ALL_ACCESS_VSEQ_SV__

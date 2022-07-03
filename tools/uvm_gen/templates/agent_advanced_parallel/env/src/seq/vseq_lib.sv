// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_VSEQ_LIB_SV__
`define __UVME_{{ upper(name) }}_ST_VSEQ_LIB_SV__


`include "uvme_{{ name }}_st_base_vseq.sv"
`include "uvme_{{ name }}_st_reads_vseq.sv"
`include "uvme_{{ name }}_st_writes_vseq.sv"
`include "uvme_{{ name }}_st_all_access_vseq.sv"
`include "uvme_{{ name }}_st_print_vseq.sv"


/**
 * Sequence library for {{ full_name }} environment.
 */
class uvme_{{ name }}_st_vseq_lib_c extends uvm_sequence_library #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   `uvm_object_utils          (uvme_{{ name }}_st_vseq_lib_c)
   `uvm_sequence_library_utils(uvme_{{ name }}_st_vseq_lib_c)
   
   
   /**
    * Initializes sequence library.
    */
   extern function new(string name="uvme_{{ name }}_st_vseq_lib");
   
endclass : uvme_{{ name }}_st_vseq_lib_c


function uvme_{{ name }}_st_vseq_lib_c::new(string name="uvme_{{ name }}_st_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   add_sequence(uvme_{{ name }}_st_reads_vseq_c     ::get_type());
   add_sequence(uvme_{{ name }}_st_writes_vseq_c    ::get_type());
   add_sequence(uvme_{{ name }}_st_all_access_vseq_c::get_type());
   add_sequence(uvme_{{ name }}_st_print_vseq_c     ::get_type());
   
endfunction : new


`endif // __UVME_{{ upper(name) }}_ST_VSEQ_LIB_SV__

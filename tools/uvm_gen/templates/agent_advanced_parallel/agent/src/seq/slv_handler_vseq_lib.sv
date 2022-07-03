// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SLV_HANDLER_VSEQ_LIB_SV__
`define __UVMA_{{ upper(name) }}_SLV_HANDLER_VSEQ_LIB_SV__


`include "uvma_{{ name }}_slv_handler_base_vseq.sv"
`include "uvma_{{ name }}_slv_handler_mem_vseq.sv"
`include "uvma_{{ name }}_slv_handler_print_vseq.sv"


/**
 * Object holding sequence library for {{ upper(name) }} agent.
 */
class uvma_{{ name }}_slv_handler_vseq_lib_c extends uvml_vseq_lib_c #(
   .REQ(uvma_{{ name }}_seq_item_c),
   .RSP(uvma_{{ name }}_seq_item_c)
);
   
   `uvm_object_utils          (uvma_{{ name }}_slv_handler_vseq_lib_c)
   `uvm_sequence_library_utils(uvma_{{ name }}_slv_handler_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvma_{{ name }}_slv_handler_vseq_lib");
   
endclass : uvma_{{ name }}_slv_handler_vseq_lib_c


function uvma_{{ name }}_slv_handler_vseq_lib_c::new(string name="uvma_{{ name }}_slv_handler_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   add_sequence(uvma_{{ name }}_slv_handler_mem_vseq_c  ::get_type());
   add_sequence(uvma_{{ name }}_slv_handler_print_vseq_c::get_type());
   
endfunction : new


`endif // __UVMA_{{ upper(name) }}_SLV_HANDLER_VSEQ_LIB_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_VSEQ_LIB_SV__
`define __UVMA_{{ name.upper() }}_VSEQ_LIB_SV__


`include "uvma_{{ name }}_transport_base_vseq.sv"


/**
 * Object holding sequence library for {{ name.upper() }} agent.
 */
class uvma_{{ name }}_vseq_lib_c extends uvml_vseq_lib_c #(
   .REQ(uvma_{{ name }}_seq_item_c),
   .RSP(uvma_{{ name }}_seq_item_c)
);
   
   `uvm_object_utils          (uvma_{{ name }}_vseq_lib_c)
   `uvm_sequence_library_utils(uvma_{{ name }}_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvma_{{ name }}_vseq_lib");
   
endclass : uvma_{{ name }}_vseq_lib_c


function uvma_{{ name }}_vseq_lib_c::new(string name="uvma_{{ name }}_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // Register sequences here
   // Ex: add_sequence(uvma_{{ name }}_transport_base_vseq_c::get_type());
   
endfunction : new


`endif // __UVMA_{{ name.upper() }}_VSEQ_LIB_SV__

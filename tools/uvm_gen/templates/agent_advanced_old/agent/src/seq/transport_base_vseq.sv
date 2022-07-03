// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_{{ name_uppercase }}_TRANSPORT_BASE_VSEQ_SV__
`define __UVMA_{{ name_uppercase }}_TRANSPORT_BASE_VSEQ_SV__


/**
 * TODO Describe uvma_{{ name }}_transport_base_vseq_c
 */
class uvma_{{ name }}_transport_base_vseq_c extends uvma_{{ name }}_base_vseq_c;
   
   `uvm_object_utils(uvma_{{ name }}_transport_base_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_transport_base_vseq");
   
   /**
    * TODO Describe uvma_{{ name }}_transport_base_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_{{ name }}_transport_base_vseq_c::process_payload()
    */
   extern virtual task process_payload(uvm_sequence_item payload);
   
endclass : uvma_{{ name }}_transport_base_vseq_c


function uvma_{{ name }}_transport_base_vseq_c::new(string name="uvma_{{ name }}_transport_base_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_{{ name }}_transport_base_vseq_c::body();
   
   uvm_sequence_item  payload;
   
   `uvm_info("{{ name_uppercase }}_TRANSPORT_BASE_VSEQ", "Transport base virtual sequence has started", UVM_HIGH)
   forever begin
      upstream_get_next_item(payload);
      process_payload       (payload);
      upstream_item_done    (payload);
   end
   
endtask : body


task uvma_{{ name }}_transport_base_vseq_c::process_payload(uvm_sequence_item payload);
   
   
   
endtask : process_payload


`endif // __UVMA_{{ name_uppercase }}_TRANSPORT_BASE_VSEQ_SV__

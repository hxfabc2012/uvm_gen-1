// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * This file contains sample code that demonstrates how to add a new virtual sequence to the {{ full_name }} UVM Environment.
 */


`ifndef __UVME_{{ name.upper() }}_MY_VSEQ_SV__
`define __UVME_{{ name.upper() }}_MY_VSEQ_SV__


/**
 * Sample sequence that runs 5 fully random items by default.
 */
class uvme_{{ name }}_my_vseq_c extends uvme_{{ name }}_base_vseq_c;
   
   // Fields
   rand int unsigned  num_items;
   
   
   `uvm_object_utils_begin(uvme_{{ name }}_my_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == 5;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_my_seq");
   
   /**
    * Generates num_items of fully random reqs.
    */
   extern virtual task body();
   
endclass : uvme_{{ name }}_my_vseq_c


function uvme_{{ name }}_my_vseq_c::new(string name="uvme_{{ name }}_my_seq");
   
   super.new(name);
   
endfunction : new


task uvme_{{ name }}_my_vseq_c::body();
   
   repeat (num_items) begin
      `uvm_do_on(req, p_sequencer.sub_sequencer)
   end
   
endtask : body


`endif __UVME_{{ name.upper() }}_MY_VSEQ_SV__

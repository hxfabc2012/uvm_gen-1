// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * This file contains sample code that demonstrates how to add a new Virtual Sequence to the {{ full_name }} UVM Agent Self-Test Environment.
 */


`ifndef __UVME_{{ name.upper() }}_MY_VSEQ_SV__
`define __UVME_{{ name.upper() }}_MY_VSEQ_SV__


/**
 * Sample sequence that runs 5 (by default) fully random items in each direction.
 */
class uvme_{{ name }}_st_my_vseq_c extends uvme_{{ name }}_st_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_{{ name }}_st_my_vseq_c)
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
   extern function new(string name="uvme_{{ name }}_st_my_seq");

   /**
    * Generates #num_items of fully random reqs in each direction.
    */
   extern virtual task body();

endclass : uvme_{{ name }}_st_my_vseq_c


function uvme_{{ name }}_st_my_vseq_c::new(string name="uvme_{{ name }}_st_my_seq");

   super.new(name);

endfunction : new


task uvme_{{ name }}_st_my_vseq_c::body();

   fork
      begin
         repeat (num_items) begin
            `uvm_do_on(req, p_sequencer.{{ mode_1 }}_vsequencer)
         end
      end
      begin
         repeat (num_items) begin
            `uvm_do_on(req, p_sequencer.{{ mode_2 }}_vsequencer)
         end
      end
   join

endtask : body


`endif __UVME_{{ name.upper() }}_MY_VSEQ_SV__

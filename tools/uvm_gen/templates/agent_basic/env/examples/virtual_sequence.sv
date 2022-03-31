// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new sequence to the ${name_normal_case} UVM Agent.


`ifndef __UVMA_${name_uppercase}_MY_SEQ_SV__
`define __UVMA_${name_uppercase}_MY_SEQ_SV__


/**
 * Sample sequence that runs 5 fully random items by default.
 */
class uvma_${name}_my_seq_c extends uvma_${name}_base_seq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvma_${name}_my_seq_c)
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
   extern function new(string name="uvma_${name}_my_seq");

   /**
    * Generates #num_items of fully random reqs.
    */
   extern virtual task body();

endclass : uvma_${name}_my_seq_c


function uvma_${name}_my_seq_c::new(string name="uvma_${name}_my_seq");

   super.new(name);

endfunction : new


task uvma_${name}_my_seq_c::body();

   repeat (num_items) begin
      `uvm_do(req)
   end

endtask : body


`endif __UVMA_${name_uppercase}_MY_SEQ_SV__

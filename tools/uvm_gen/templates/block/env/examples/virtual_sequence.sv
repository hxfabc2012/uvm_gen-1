// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains sample code that demonstrates how to add a new sequence to the ${name_normal_case} Block environment.


`ifndef __UVME_${name_uppercase}_MY_SEQ_SV__
`define __UVME_${name_uppercase}_MY_SEQ_SV__


/**
 * Sample sequence that runs 5 fully random items by default.
 */
class uvme_${name}_my_seq_c extends uvme_${name}_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_${name}_my_seq_c)
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
   extern function new(string name="uvme_${name}_my_seq");

   /**
    * Generates #num_items of fully random reqs.
    */
   extern virtual task body();

endclass : uvme_${name}_my_seq_c


function uvme_${name}_my_seq_c::new(string name="uvme_${name}_my_seq");

   super.new(name);

endfunction : new


task uvme_${name}_my_seq_c::body();

   uvma_${name}_cp_seq_item_c      cp_req    ;
   uvma_${name}_dp_in_seq_item_c   dp_in_req ;
   uvma_${name}_dp_out_seq_item_c  dp_out_req;

   fork
      begin
         repeat (num_items) begin
            `uvm_do_on(cp_req   , p_sequencer.cp_sequencer   )
            `uvm_do_on(dp_in_req, p_sequencer.dp_in_sequencer)
         end
      end

      forever begin
         `uvm_do_on(dp_out_req, p_sequencer.dp_out_sequencer)
      end
   join_any

endtask : body


`endif // __UVME_${name_uppercase}_MY_SEQ_SV__

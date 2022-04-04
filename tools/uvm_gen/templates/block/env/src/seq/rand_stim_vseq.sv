// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_RAND_STIM_VSEQ_SV__
`define __UVME_${name_uppercase}_RAND_STIM_VSEQ_SV__


/**
 * Sample sequence that runs 10 fully random items by default.
 */
class uvme_${name}_rand_stim_vseq_c extends uvme_${name}_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_items; ///< Number of sequence items to be generated.
   /// @}


   `uvm_object_utils_begin(uvme_${name}_rand_stim_vseq_c)
      `uvm_field_int(num_items, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default values for random fields.
    */
   constraint defaults_cons {
      soft num_items == 10;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_rand_stim_vseq");

   /**
    * Generates #num_items of fully random reqs.
    */
   extern virtual task body();

endclass : uvme_${name}_rand_stim_vseq_c


function uvme_${name}_rand_stim_vseq_c::new(string name="uvme_${name}_rand_stim_vseq");

   super.new(name);

endfunction : new


task uvme_${name}_rand_stim_vseq_c::body();

   uvma_${name}_cp_seq_item_c      cp_req    ;
   uvma_${name}_dp_in_seq_item_c   dp_in_req ;
   uvma_${name}_dp_out_seq_item_c  dp_out_req;

   fork
      begin
         for (int unsigned ii=0; ii<num_items; ii++) begin
            `uvm_info("${name_uppercase}_VSEQ", $sformatf("Driving item #%0d of %0d", (ii+1), num_items), UVM_HIGH)
            `uvm_do_on(cp_req   , p_sequencer.cp_sequencer   )
            `uvm_do_on(dp_in_req, p_sequencer.dp_in_sequencer)
         end
      end

      forever begin
         `uvm_do_on(dp_out_req, p_sequencer.dp_out_sequencer)
      end
   join_any
   disable fork;

endtask : body


`endif // __UVME_${name_uppercase}_RAND_STIM_VSEQ_SV__

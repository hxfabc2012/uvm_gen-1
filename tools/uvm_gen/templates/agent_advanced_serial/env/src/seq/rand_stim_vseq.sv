// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_RAND_STIM_VSEQ_SV__
`define __UVME_{{ name.upper() }}_ST_RAND_STIM_VSEQ_SV__


/**
 * Virtual Sequence sending a fixed number of completely random sequence items to {{ mode_1 }} and {{ mode_1 }} Virtual Sequencers.
 */
class uvme_{{ name }}_st_rand_stim_vseq_c extends uvme_{{ name }}_st_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_{{ tx }}_seq_items; ///< Number of {{ tx.upper() }} Sequence Items to generate.
   rand int unsigned  num_{{ rx }}_seq_items; ///< Number of {{ rx.upper() }} Sequence Items to generate.
   /// @{


   `uvm_object_utils_begin(uvme_{{ name }}_st_rand_stim_vseq_c)
       `uvm_field_int(num_{{ tx }}_seq_items, UVM_DEFAULT + UVM_DEC)
       `uvm_field_int(num_{{ rx }}_seq_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Sets safe defaults.
    */
   constraint defaults_cons {
      soft num_{{ tx }}_seq_items == uvme_{{ name }}_st_rand_stim_default_num_seq_items;
      soft num_{{ rx }}_seq_items == uvme_{{ name }}_st_rand_stim_default_num_seq_items;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_rand_stim_vseq");

   /**
    * Generates Sequence Items in both directions.
    */
   extern virtual task body();

endclass : uvme_{{ name }}_st_rand_stim_vseq_c


function uvme_{{ name }}_st_rand_stim_vseq_c::new(string name="uvme_{{ name }}_st_rand_stim_vseq");

   super.new(name);

endfunction : new


task uvme_{{ name }}_st_rand_stim_vseq_c::body();

   uvma_{{ name }}_seq_item_c  {{ tx }}_seq_item, {{ rx }}_seq_item;

   `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ", "Starting sequence", UVM_MEDIUM)
   fork
      begin
         `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ tx.upper() }}", "Starting stimulus", UVM_LOW)
         for (int unsigned ii=0; ii<num_{{ tx }}_seq_items; ii++) begin
            `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ tx.upper() }}", $sformatf("Starting item %0d/%0d", (ii+1), num_{{ tx }}_seq_items), UVM_HIGH)
            `uvm_do_on_pri_with({{ tx }}_seq_item, p_sequencer.{{ mode_1 }}_vsequencer, uvme_{{ name }}_st_rand_stim_sqr_priority, {
               header == UVMA_{{ name.upper() }}_HEADER_DATA;
            })
            `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ tx.upper() }}", $sformatf("Finished item %0d/%0d", (ii+1), num_{{ tx }}_seq_items), UVM_HIGH)
         end
      end
      begin
         `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ rx.upper() }}", "Starting stimulus", UVM_LOW)
         for (int unsigned jj=0; jj<num_{{ rx }}_seq_items; jj++) begin
            `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ rx.upper() }}", $sformatf("Starting item %0d/%0d", (jj+1), num_{{ rx }}_seq_items), UVM_HIGH)
            `uvm_do_on_pri_with({{ rx }}_seq_item, p_sequencer.{{ mode_2 }}_vsequencer, uvme_{{ name }}_st_rand_stim_sqr_priority, {
               header == UVMA_{{ name.upper() }}_HEADER_DATA;
            })
            `uvm_info("{{ name.upper() }}_ST_RAND_STIM_VSEQ_{{ rx.upper() }}", $sformatf("Finished item %0d/%0d", (jj+1), num_{{ rx }}_seq_items), UVM_HIGH)
         end
      end
   join

endtask : body


`endif // __UVME_{{ name.upper() }}_ST_RAND_STIM_VSEQ_SV__

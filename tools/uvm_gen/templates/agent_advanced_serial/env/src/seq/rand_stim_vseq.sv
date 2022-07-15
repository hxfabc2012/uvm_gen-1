// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__
`define __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_{{ name }}_st_rand_traffic_vseq_c
 */
class uvme_{{ name }}_st_rand_traffic_vseq_c extends uvme_{{ name }}_st_base_vseq_c;

   /// @defgroup Knobs
   /// @{
   rand int unsigned  num_{{ tx }}_seq_items; ///<
   rand int unsigned  num_{{ rx }}_seq_items; ///<
   rand int unsigned  sqr_priority;
   /// @{


   `uvm_object_utils_begin(uvme_{{ name }}_st_rand_traffic_vseq_c)
       `uvm_field_int(num_{{ tx }}_seq_items, UVM_DEFAULT + UVM_DEC)
       `uvm_field_int(num_{{ rx }}_seq_items, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    *
    */
   constraint defaults_cons {
      soft num_{{ tx }}_seq_items == uvme_{{ name }}_st_rand_traffic_default_num_seq_items;
      soft num_{{ rx }}_seq_items == uvme_{{ name }}_st_rand_traffic_default_num_seq_items;
      soft sqr_priority == uvme_{{ name }}_st_rand_traffic_default_sqr_priority;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_rand_traffic_vseq");

   /**
    * TODO Describe uvme_{{ name }}_st_rand_traffic_vseq_c::body()
    */
   extern virtual task body();

endclass : uvme_{{ name }}_st_rand_traffic_vseq_c


function uvme_{{ name }}_st_rand_traffic_vseq_c::new(string name="uvme_{{ name }}_st_rand_traffic_vseq");

   super.new(name);

endfunction : new


task uvme_{{ name }}_st_rand_traffic_vseq_c::body();

   uvma_{{ name }}_seq_item_c  {{ tx }}_seq_item, {{ rx }}_seq_item;

   fork
      begin : {{ tx }}
         `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(tx) }}", "Starting traffic", UVM_LOW)
         for (int unsigned ii=0; ii<num_{{ tx }}_seq_items; ii++) begin
            `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(tx) }}", $sformatf("Starting item %0d of %0d", (ii+1), num_{{ tx }}_seq_items), UVM_HIGH)
            `uvm_do_on_pri({{ tx }}_seq_item, p_sequencer.{{ mode_1 }}_vsequencer, sqr_priority)
            `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(tx) }}", $sformatf("Finished item %0d of %0d", (ii+1), num_{{ tx }}_seq_items), UVM_HIGH)
         end
      end
      begin : {{ rx }}
         `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(rx) }}", "Starting traffic", UVM_LOW)
         for (int unsigned ii=0; ii<num_{{ rx }}_seq_items; ii++) begin
            `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(rx) }}", $sformatf("Starting item %0d of %0d", (ii+1), num_{{ rx }}_seq_items), UVM_HIGH)
            `uvm_do_on_pri({{ rx }}_seq_item, p_sequencer.{{ mode_2 }}_vsequencer, sqr_priority)
            `uvm_info("{{ upper(name }}_ST_RAND_TRAFFIC_VSEQ_{{ upper(rx) }}", $sformatf("Finished item %0d of %0d", (ii+1), num_{{ rx }}_seq_items), UVM_HIGH)
         end
      end
   join

endtask : body


`endif // __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__
`define __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_{{ name }}_st_rand_traffic_vseq_c
 */
class uvme_{{ name }}_st_rand_traffic_vseq_c extends uvme_{{ name }}_st_base_vseq_c;
   
   rand int unsigned  num_tx_frames;
   rand int unsigned  num_rx_frames;
   
   
   `uvm_object_utils_begin(uvme_{{ name }}_st_rand_traffic_vseq_c)
       `uvm_field_int(num_tx_frames, UVM_DEFAULT + UVM_DEC)
       `uvm_field_int(num_rx_frames, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      num_tx_frames == 10;
      num_rx_frames == 10;
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
   
   uvma_{{ name }}_seq_item_c  tx_frame;
   uvma_{{ name }}_seq_item_c  rx_frame;
   
   fork
      begin : tx
         `uvm_info("VSEQ", "Starting traffic on Tx", UVM_LOW)
         repeat (num_tx_frames) begin
            `uvm_do_on_pri(tx_frame, p_sequencer.{{ mode_1 }}_sequencer, 1_000)
         end
      end
      
      begin : rx
         `uvm_info("VSEQ", "Starting traffic on Rx", UVM_LOW)
         repeat (num_rx_frames) begin
            `uvm_do_on_pri(rx_frame, p_sequencer.{{ mode_2 }}_sequencer, 1_000)
         end
      end
   join
   
endtask : body


`endif // __UVME_{{ upper(name) }}_ST_RAND_TRAFFIC_VSEQ_SV__

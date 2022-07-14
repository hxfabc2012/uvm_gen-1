// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__
`define __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__


/**
 * TODO Describe uvma_{{ name }}_mon_fsm_cntxt_c
 */
class uvma_{{ name }}_mon_fsm_cntxt_c extends uvm_object;

   uvma_{{ name }}_mon_fsm_enum  state          ; ///<
   logic                     data_q[$]     ; ///<
   bit                       frame_data[]  ; ///<
   shortint                  zero_cnt       ; ///<
   shortint                  startup_counter; ///<
   shortint                  rx_index       ; ///<


   `uvm_object_utils_begin(uvma_{{ name }}_mon_fsm_cntxt_c)
      `uvm_field_enum(uvma_{{ name }}_mon_fsm_enum, state, UVM_DEFAULT)
      `uvm_field_queue_int(rx_data , UVM_DEFAULT)
      `uvm_field_array_int(rx_frame, UVM_DEFAULT)
      `uvm_field_int(zero_cnt       , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(startup_counter, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(rx_index       , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_fsm_cntxt");

   /**
    * TODO Describe uvma_{{ name }}_mon_fsm_cntxt_c::reset()
    */
   extern function void reset();

endclass : uvma_{{ name }}_mon_fsm_cntxt_c


function uvma_{{ name }}_mon_fsm_cntxt_c::new(string name="uvma_{{ name }}_mon_fsm_cntxt");

   super.new(name);

endfunction : new


function void uvma_{{ name }}_mon_fsm_cntxt_c::reset();

   state = UVMA_{{ upper(name) }}_MON_FSM_INIT;
   rx_data.delete();
   rx_frame = new[32];
   zero_cnt = 0;
   startup_counter = 0;
   rx_index = 0;

endfunction : reset


`endif // __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__

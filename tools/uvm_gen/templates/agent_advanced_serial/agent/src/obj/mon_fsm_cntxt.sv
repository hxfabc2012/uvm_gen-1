// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__
`define __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__


/**
 * TODO Describe uvma_{{ name }}_mon_fsm_cntxt_c
 */
class uvma_{{ name }}_mon_fsm_cntxt_c extends uvm_object;

   /// @defgroup Integrals
   /// @{
   uvma_{{ name }}_mon_fsm_enum  state; ///<
   logic         data_q[$]     ; ///<
   bit           trn_data[]    ; ///<
   int unsigned  training_count; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_mon_fsm_cntxt_c)
      `uvm_field_enum(uvma_{{ name }}_mon_fsm_enum, state, UVM_DEFAULT)
      `uvm_field_queue_int(data_q  , UVM_DEFAULT)
      `uvm_field_array_int(trn_data, UVM_DEFAULT)
      `uvm_field_int(training_count, UVM_DEFAULT + UVM_DEC)
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
   data_q.delete();
   trn_data = new[32];
   training_count = 0;

endfunction : reset


`endif // __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__

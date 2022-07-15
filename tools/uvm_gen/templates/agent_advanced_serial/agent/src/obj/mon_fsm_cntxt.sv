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
   int unsigned  training_count; ///<
   realtime      trn_start     ; ///<
   realtime      trn_end       ; ///<
   /// @}

   /// @defgroup Data
   /// @{
   logic     data_q      [$]; ///<
   realtime  timestamps_q[$]; ///<
   bit       trn_data    [] ; ///<
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_mon_fsm_cntxt_c)
      `uvm_field_enum(uvma_{{ name }}_mon_fsm_enum, state, UVM_DEFAULT)
      `uvm_field_int(training_count, UVM_DEFAULT + UVM_DEC)
      `uvm_field_real(trn_start    , UVM_DEFAULT)
      `uvm_field_real(trn_end      , UVM_DEFAULT)
      `uvm_field_queue_int (data_q      , UVM_DEFAULT)
      `uvm_field_queue_real(timestamps_q, UVM_DEFAULT)
      `uvm_field_array_int (trn_data    , UVM_DEFAULT)
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

   state          = UVMA_{{ upper(name) }}_MON_FSM_INIT;
   training_count = 0;
   trn_start      = 0;
   trn_end        = 0;
   data_q      .delete();
   timestamps_q.delete();
   trn_data = new[32];

endfunction : reset


`endif // __UVMA_{{ upper(name) }}_MON_FSM_CNTXT_SV__

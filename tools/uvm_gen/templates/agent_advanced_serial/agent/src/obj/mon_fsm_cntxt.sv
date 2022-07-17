// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_MON_FSM_CNTXT_SV__
`define __UVMA_{{ name.upper() }}_MON_FSM_CNTXT_SV__


/**
 * TODO Describe uvma_{{ name }}_mon_fsm_cntxt_c
 */
class uvma_{{ name }}_mon_fsm_cntxt_c extends uvm_object;

   /// @defgroup Integrals
   /// @{
   uvma_{{ name }}_mon_fsm_enum  state; ///< Current state for this FSM.
   int unsigned  training_count       ; ///< Count of correct consecutive bits of the training sequence observed.
   int unsigned  num_consecutive_edges; ///< Count of bit transitions seen at the correct intervals.
   realtime      trn_start            ; ///< Timestamp for bit 0 of currently sampled transaction.
   realtime      trn_end              ; ///< Timestamp for last bit of currently sampled transaction.
   /// @}

   /// @defgroup Data
   /// @{
   logic     data_q      [$]; ///< Queue of decoded bits obtained from monitor.
   realtime  timestamps_q[$]; ///< Timestamp for each bit in #data_q.
   bit       trn_data    [] ; ///< Data ready to be unpacked.
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_mon_fsm_cntxt_c)
      `uvm_field_enum(uvma_{{ name }}_mon_fsm_enum, state, UVM_DEFAULT)
      `uvm_field_int(training_count       , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(num_consecutive_edges, UVM_DEFAULT + UVM_DEC)
      `uvm_field_real(trn_start    , UVM_DEFAULT)
      `uvm_field_real(trn_end      , UVM_DEFAULT)
      `uvm_field_queue_int(data_q  , UVM_DEFAULT)
      `uvm_field_array_int(trn_data, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon_fsm_cntxt");

   /**
    * Returns all state variables to initial values.
    */
   extern function void reset();

endclass : uvma_{{ name }}_mon_fsm_cntxt_c


function uvma_{{ name }}_mon_fsm_cntxt_c::new(string name="uvma_{{ name }}_mon_fsm_cntxt");

   super.new(name);

endfunction : new


function void uvma_{{ name }}_mon_fsm_cntxt_c::reset();

   state                 = UVMA_{{ name.upper() }}_MON_FSM_INIT;
   training_count        = 0;
   num_consecutive_edges = 0;
   trn_start             = 0;
   trn_end               = 0;
   data_q      .delete();
   timestamps_q.delete();
   trn_data = new[uvma_{{ name }}_trn_length];

endfunction : reset


`endif // __UVMA_{{ name.upper() }}_MON_FSM_CNTXT_SV__

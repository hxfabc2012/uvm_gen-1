// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_CNTXT_SV__
`define __UVMA_{{ name.upper() }}_CNTXT_SV__


/**
 * Object encapsulating all state variables for all {{ full_name }} Agent (uvma_{{ name }}_agent_c) components.
 */
class uvma_{{ name }}_cntxt_c extends uvm_object;

   virtual uvma_{{ name }}_if  vif; ///< Handle to agent interface.

   /// @defgroup Integrals
   /// @{
   uvml_reset_state_enum  reset_state; ///< Reset state as observed by monitor (uvma_{{ name }}_mon_c).
   /// @}

   /// @defgroup Objects
   /// @{
   uvm_event  sample_cfg_e  ; ///< Triggers sampling of the agent configuration by the functional coverage model.
   uvm_event  sample_cntxt_e; ///< Triggers sampling of the agent context by the functional coverage model.
   /// @}

   /// @defgroup Sequences
   /// @{
   uvm_sequence_base  mon_vseq   ; ///< Monitor Virtual Sequence instance.
   uvm_sequence_base  idle_vseq  ; ///< Idle Generating Virtual Sequence instance.
   uvm_sequence_base  {{ tx }}_drv_vseq; ///< {{ tx.upper() }} Driver Phy Virtual Sequence instance.
   uvm_sequence_base  {{ rx }}_drv_vseq; ///< {{ rx.upper() }} Driver Phy Virtual Sequence instance.
   /// @}

   /// @defgroup FSM
   /// @{
   uvma_{{ name }}_mon_fsm_cntxt_c  {{ tx }}_mon_fsm_cntxt; ///< Monitor {{ tx.upper() }} FSM data.
   uvma_{{ name }}_mon_fsm_cntxt_c  {{ rx }}_mon_fsm_cntxt; ///< Monitor {{ rx.upper() }} FSM data.
   /// @}


   `uvm_object_utils_begin(uvma_{{ name }}_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
      `uvm_field_object({{ tx }}_mon_fsm_cntxt, UVM_DEFAULT)
      `uvm_field_object({{ rx }}_mon_fsm_cntxt, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Builds objects.
    */
   extern function new(string name="uvma_{{ name }}_cntxt");

   /**
    * Returns all state variables to initial values.
    * Called by monitor (uvma_${name}_mon_c) when it observes a reset pulse.
    */
   extern function void reset();

endclass : uvma_{{ name }}_cntxt_c


function uvma_{{ name }}_cntxt_c::new(string name="uvma_{{ name }}_cntxt");

   super.new(name);
   reset_state = UVML_RESET_STATE_PRE_RESET;
   {{ tx }}_mon_fsm_cntxt = uvma_{{ name }}_mon_fsm_cntxt_c::type_id::create("{{ tx }}_mon_fsm_cntxt");
   {{ rx }}_mon_fsm_cntxt = uvma_{{ name }}_mon_fsm_cntxt_c::type_id::create("{{ rx }}_mon_fsm_cntxt");
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");

endfunction : new


function void uvma_{{ name }}_cntxt_c::reset();

   {{ tx }}_mon_fsm_cntxt.reset();
   {{ rx }}_mon_fsm_cntxt.reset();

endfunction : reset


`endif // __UVMA_{{ name.upper() }}_CNTXT_SV__

// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_DP_CNTXT_SV__
`define __UVMA_${name_uppercase}_DP_CNTXT_SV__


/**
 * Object encapsulating all state variables for all ${name_normal_case} Data Path agent (uvma_${name}_dp_agent_c) components.
 */
class uvma_${name}_dp_cntxt_c extends uvm_object;

   virtual uvma_${name}_dp_if  vif; ///< Handle to agent virtual interface.  Used by monitor and driver.

   /// @defgroup Integrals
   /// @{
   uvml_reset_state_enum  reset_state = UVML_RESET_STATE_PRE_RESET;
   /// @}

   /// @defgroup Objects
   /// @{
   uvm_event  sample_cfg_e  ; ///< Triggers sampling of the agent configuration by the functional coverage model.
   uvm_event  sample_cntxt_e; ///< Triggers sampling of the agent context by the functional coverage model.
   /// @}


   `uvm_object_utils_begin(uvma_${name}_dp_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)

      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Creates event objects.
    */
   extern function new(string name="uvma_${name}_dp_cntxt");

   /**
    * Returns all state variables to initial values.
    * Called by monitor (uvma_${name}_dp_mon_c) when it witnesses a reset pulse.
    */
   extern function void reset();

endclass : uvma_${name}_dp_cntxt_c


function uvma_${name}_dp_cntxt_c::new(string name="uvma_${name}_dp_cntxt");

   super.new(name);

   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");

endfunction : new


function void uvma_${name}_dp_cntxt_c::reset();

   // TODO Implement uvma_${name}_dp_cntxt_c::reset()
   //      Ex: abc = 0;

endfunction : reset


`endif // __UVMA_${name_uppercase}_DP_CNTXT_SV__

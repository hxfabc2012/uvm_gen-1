// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_DP_CFG_SV__
`define __UVMA_${name_uppercase}_DP_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all ${name_normal_case} Data Path agent (uvma_${name}_dp_agent_c) components.
 */
class uvma_${name}_dp_cfg_c extends uvm_object;

   /// @defgroup Generic options
   /// @{
   rand bit                      enabled          ; ///< Components do not execute their run_phase() if '0'.
   rand uvm_active_passive_enum  is_active        ; ///< Driver does not execute its run_phase() if 'UVM_PASSIVE'.
   rand uvml_reset_type_enum     reset_type       ; ///< Sets whether the monitor is sensitive to a/synchronous reset.
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< Arbitration mode for the sequencer.
   rand bit                      cov_model_enabled; ///< Gates the connection of the functional coverage model.
   rand bit                      trn_log_enabled  ; ///< Gates the connection of the transaction logger.
   /// @}


   `uvm_object_utils_begin(uvma_${name}_dp_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive, synchronous reset with transaction logging enabled.
    */
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_dp_cfg");

endclass : uvma_${name}_dp_cfg_c


function uvma_${name}_dp_cfg_c::new(string name="uvma_${name}_dp_cfg");

   super.new(name);

endfunction : new


`endif // __UVMA_${name_uppercase}_DP_CFG_SV__

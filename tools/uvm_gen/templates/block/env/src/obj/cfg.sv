// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CFG_SV__
`define __UVME_${name_uppercase}_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the ${name_normal_case} Block environment
 * (uvme_${name}_env_c) components.
 */
class uvme_${name}_cfg_c extends uvml_cfg_c;

   /// @defgroup Generic options
   /// @{
   rand bit                      enabled              ; ///< Enables/disables all components' run_phase() execution
   rand uvm_active_passive_enum  is_active            ; ///< Enables/disables stimulus generation
   rand bit                      scoreboarding_enabled; ///< Connects/disconnects scoreboards
   rand bit                      cov_model_enabled    ; ///< Enables/disables agents' functional coverage models.
   rand bit                      trn_log_enabled      ; ///< Enables/disables transaction logging.
   /// @}

   /// @defgroup Block parameters
   /// @{
   rand uvml_reset_type_enum  reset_type; ///< Specifies if reset pulse is sync/async
   rand int unsigned          clk_frequency; ///< Frequency for clock generation (Hz)
   /// @}

   /// @defgroup Agent configuration handles
   /// @{
   rand uvma_clk_cfg_c    clk_cfg  ; ///< Clock agent configuration
   rand uvma_reset_cfg_c  reset_cfg; ///< Reset agent configuration
   rand uvma_${name}_cp_cfg_c      cp_cfg    ; ///< Control plane agent configuration
   rand uvma_${name}_dp_in_cfg_c   dp_in_cfg ; ///< Data plane input agent configuration
   rand uvma_${name}_dp_out_cfg_c  dp_out_cfg; ///< Data plane output agent configuration
   /// @}

   /// @defgroup Objects
   /// @{
   rand uvml_sb_simplex_cfg_c  sb_dp_cfg; ///< Data path scoreboard configuration
   /// @}


   `uvm_object_utils_begin(uvme_${name}_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)

      `uvm_field_int(clk_frequency, UVM_DEFAULT + UVM_DEC)

      `uvm_field_object(clk_cfg   , UVM_DEFAULT)
      `uvm_field_object(reset_cfg , UVM_DEFAULT)
      `uvm_field_object(cp_cfg    , UVM_DEFAULT)
      `uvm_field_object(dp_in_cfg , UVM_DEFAULT)
      `uvm_field_object(dp_out_cfg, UVM_DEFAULT)

      `uvm_field_object(sb_dp_cfg, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive with scoreboarding and transaction logging enabled.
    */
   constraint defaults_cons {
      soft enabled                == 1;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
           reset_type             == UVML_RESET_TYPE_SYNCHRONOUS;
           clk_frequency          == uvme_${name}_default_clk_frequency;
   }

   /**
    * Sets agents configuration.
    */
   constraint agent_cfg_cons {
      reset_cfg .reset_type == reset_type;
      reset_cfg .polarity   == UVML_RESET_ACTIVE_LOW;
      cp_cfg    .reset_type == reset_type;
      dp_in_cfg .reset_type == reset_type;
      dp_out_cfg.reset_type == reset_type;
      clk_cfg   .cov_model_enabled == 0;
      reset_cfg .cov_model_enabled == 0;

      if (enabled) {
         clk_cfg   .enabled == 1;
         reset_cfg .enabled == 1;
         cp_cfg    .enabled == 1;
         dp_in_cfg .enabled == 1;
         dp_out_cfg.enabled == 1;
      }
      else {
         clk_cfg   .enabled == 0;
         reset_cfg .enabled == 0;
         cp_cfg    .enabled == 0;
         dp_in_cfg .enabled == 0;
         dp_out_cfg.enabled == 0;
      }

      if (is_active == UVM_ACTIVE) {
         clk_cfg   .is_active == UVM_ACTIVE;
         reset_cfg .is_active == UVM_ACTIVE;
         cp_cfg    .is_active == UVM_ACTIVE;
         dp_in_cfg .is_active == UVM_ACTIVE;
         dp_out_cfg.is_active == UVM_ACTIVE;
      }
      else {
         clk_cfg   .is_active == UVM_PASSIVE;
         reset_cfg .is_active == UVM_PASSIVE;
         cp_cfg    .is_active == UVM_PASSIVE;
         dp_in_cfg .is_active == UVM_PASSIVE;
         dp_out_cfg.is_active == UVM_PASSIVE;
      }

      if (trn_log_enabled) {
         clk_cfg   .trn_log_enabled == 1;
         reset_cfg .trn_log_enabled == 1;
         cp_cfg    .trn_log_enabled == 1;
         dp_in_cfg .trn_log_enabled == 1;
         dp_out_cfg.trn_log_enabled == 1;
      }
      else {
         clk_cfg   .trn_log_enabled == 0;
         reset_cfg .trn_log_enabled == 0;
         cp_cfg    .trn_log_enabled == 0;
         dp_in_cfg .trn_log_enabled == 0;
         dp_out_cfg.trn_log_enabled == 0;
      }

      if (cov_model_enabled) {
         cp_cfg    .cov_model_enabled == 1;
         dp_in_cfg .cov_model_enabled == 1;
         dp_out_cfg.cov_model_enabled == 1;
      }
      else {
         cp_cfg    .cov_model_enabled == 0;
         dp_in_cfg .cov_model_enabled == 0;
         dp_out_cfg.cov_model_enabled == 0;
      }
   }

   /**
    * Sets scoreboard configuration.
    */
   constraint sb_cons {
      sb_dp_cfg.enabled == scoreboarding_enabled;
      sb_dp_cfg.mode    == UVML_SB_MODE_IN_ORDER;
   }


   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_${name}_cfg");

endclass : uvme_${name}_cfg_c


function uvme_${name}_cfg_c::new(string name="uvme_${name}_cfg");

   super.new(name);

   clk_cfg    = uvma_clk_cfg_c  ::type_id::create("clk_cfg"  );
   reset_cfg  = uvma_reset_cfg_c::type_id::create("reset_cfg");
   cp_cfg     = uvma_${name}_cp_cfg_c    ::type_id::create("cp_cfg"    );
   dp_in_cfg  = uvma_${name}_dp_in_cfg_c ::type_id::create("dp_in_cfg" );
   dp_out_cfg = uvma_${name}_dp_out_cfg_c::type_id::create("dp_out_cfg");
   sb_dp_cfg  = uvml_sb_simplex_cfg_c::type_id::create("sb_dp_cfg");

endfunction : new


`endif // __UVME_${name_uppercase}_CFG_SV__

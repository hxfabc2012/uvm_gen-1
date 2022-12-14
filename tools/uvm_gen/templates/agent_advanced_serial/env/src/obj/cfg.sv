// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_CFG_SV__
`define __UVME_{{ name.upper() }}_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running {{ full_name }} UVM Agent Self-Testing
 * Environment (uvme_{{ name }}_st_env_c) components.
 */
class uvme_{{ name }}_st_cfg_c extends uvml_cfg_c;

   /// @defgroup Integrals
   /// @{
   rand bit                      enabled              ; ///< Enables/disables creation of all sub-components.
   rand uvm_active_passive_enum  is_active            ; ///< Sets all agents as active/passive.
   rand uvml_reset_type_enum     reset_type           ; ///< Sets the type of reset the agent is sensitive to.
   rand bit                      scoreboarding_enabled; ///< Enables/disables creation of predictor and scoreboard.
   rand bit                      cov_model_enabled    ; ///< Enables/disables functional coverage models.
   rand bit                      trn_log_enabled      ; ///< Enables/disables transaction logging.
   /// @}

   /// @defgroup Objects
   /// @{
   rand uvma_{{ name }}_cfg_c  {{ mode_1 }}_cfg  ; ///< {{ mode_1.upper() }} Agent configuration handle.
   rand uvma_{{ name }}_cfg_c  {{ mode_2 }}_cfg  ; ///< {{ mode_2.upper() }} Agent configuration handle.
   rand uvma_{{ name }}_cfg_c  passive_cfg  ; ///< Passive Agent configuration handle.
   rand uvml_sb_simplex_cfg_c  sb_{{ tx }}_cfg; ///< {{ tx.upper() }} Scoreboard configuration handle.
   rand uvml_sb_simplex_cfg_c  sb_{{ rx }}_cfg; ///< {{ rx.upper() }} Scoreboard configuration handle.
   rand uvml_sb_simplex_cfg_c  sb_{{ mode_1 }}_cfg; ///< {{ mode_1.upper() }} Scoreboard configuration handle.
   rand uvml_sb_simplex_cfg_c  sb_{{ mode_2 }}_cfg; ///< {{ mode_2.upper() }} Scoreboard configuration handle.
   /// @}


   `uvm_object_utils_begin(uvme_{{ name }}_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type           , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      `uvm_field_object({{ mode_1 }}_cfg  , UVM_DEFAULT)
      `uvm_field_object({{ mode_2 }}_cfg  , UVM_DEFAULT)
      `uvm_field_object(passive_cfg  , UVM_DEFAULT)
      `uvm_field_object(sb_{{ tx }}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_{{ rx }}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_{{ mode_1 }}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_{{ mode_2 }}_cfg, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Sets safe defaults.
    */
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }

   /**
    * Sets all configuration fields for {{ mode_1.upper() }} agent.
    */
   constraint agent_{{ mode_1 }}_cfg_cons {
      {{ mode_1 }}_cfg.drv_mode == UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }};
      {{ mode_1 }}_cfg.bypass_mode == 0;
      {{ mode_1 }}_cfg.reset_type == reset_type;
      if (enabled) {
         {{ mode_1 }}_cfg.enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg.enabled == 0;
      }
      if (is_active == UVM_ACTIVE) {
         {{ mode_1 }}_cfg.is_active == UVM_ACTIVE;
      }
      else {
         {{ mode_1 }}_cfg.is_active == UVM_PASSIVE;
      }
      if (cov_model_enabled) {
         {{ mode_1 }}_cfg.cov_model_enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg.cov_model_enabled == 0;
      }
      if (trn_log_enabled) {
         {{ mode_1 }}_cfg.trn_log_enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg.trn_log_enabled == 0;
      }
   }

   /**
    * Sets all configuration fields for {{ mode_2.upper() }} agent.
    */
   constraint agent_{{ mode_2 }}_cfg_cons {
      {{ mode_2 }}_cfg.drv_mode == UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }};
      {{ mode_2 }}_cfg.bypass_mode == 0;
      {{ mode_2 }}_cfg.reset_type == reset_type;
      if (enabled) {
         {{ mode_2 }}_cfg.enabled == 1;
      }
      else {
         {{ mode_2 }}_cfg.enabled == 0;
      }
      if (is_active == UVM_ACTIVE) {
         {{ mode_2 }}_cfg.is_active == UVM_ACTIVE;
      }
      else {
         {{ mode_2 }}_cfg.is_active == UVM_PASSIVE;
      }
      if (cov_model_enabled) {
         {{ mode_2 }}_cfg.cov_model_enabled == 1;
      }
      else {
         {{ mode_2 }}_cfg.cov_model_enabled == 0;
      }
      if (trn_log_enabled) {
         {{ mode_2 }}_cfg.trn_log_enabled == 1;
      }
      else {
         {{ mode_2 }}_cfg.trn_log_enabled == 0;
      }
   }

   /**
    * Sets all configuration fields for passive agent.
    */
   constraint agent_passive_cfg_cons {
      passive_cfg.bypass_mode == 0;
      passive_cfg.reset_type  == reset_type;
      passive_cfg.is_active   == UVM_PASSIVE;
      if (enabled) {
         passive_cfg.enabled == 1;
      }
      else {
         passive_cfg.enabled == 0;
      }
      if (cov_model_enabled) {
         passive_cfg.cov_model_enabled == 1;
      }
      else {
         passive_cfg.cov_model_enabled == 0;
      }
      if (trn_log_enabled) {
         passive_cfg.trn_log_enabled == 1;
      }
      else {
         passive_cfg.trn_log_enabled == 0;
      }
   }

   /**
    * Sets all scoreboard configuration fields.
    */
   constraint sb_cfg_cons {
      sb_{{ tx }}_cfg.mode == UVML_SB_MODE_IN_ORDER;
      sb_{{ rx }}_cfg.mode == UVML_SB_MODE_IN_ORDER;
      sb_{{ mode_1 }}_cfg.mode == UVML_SB_MODE_IN_ORDER;
      sb_{{ mode_2 }}_cfg.mode == UVML_SB_MODE_IN_ORDER;
      if (scoreboarding_enabled) {
         sb_{{ tx }}_cfg.enabled == 1;
         sb_{{ rx }}_cfg.enabled == 1;
         sb_{{ mode_1 }}_cfg.enabled == 1;
         sb_{{ mode_2 }}_cfg.enabled == 1;
      }
      else {
         sb_{{ tx }}_cfg.enabled == 0;
         sb_{{ rx }}_cfg.enabled == 0;
         sb_{{ mode_1 }}_cfg.enabled == 0;
         sb_{{ mode_2 }}_cfg.enabled == 0;
      }
   }


   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_{{ name }}_st_cfg");

endclass : uvme_{{ name }}_st_cfg_c


function uvme_{{ name }}_st_cfg_c::new(string name="uvme_{{ name }}_st_cfg");

   super.new(name);
   {{ mode_1 }}_cfg = uvma_{{ name }}_cfg_c::type_id::create("{{ mode_1 }}_cfg");
   {{ mode_2 }}_cfg = uvma_{{ name }}_cfg_c::type_id::create("{{ mode_2 }}_cfg");
   passive_cfg = uvma_{{ name }}_cfg_c::type_id::create("passive_cfg");
   sb_{{ tx }}_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_{{ tx }}_cfg");
   sb_{{ rx }}_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_{{ rx }}_cfg");
   sb_{{ mode_1 }}_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_{{ mode_1 }}_cfg");
   sb_{{ mode_2 }}_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_{{ mode_2 }}_cfg");

endfunction : new


`endif // __UVME_{{ name.upper() }}_ST_CFG_SV__

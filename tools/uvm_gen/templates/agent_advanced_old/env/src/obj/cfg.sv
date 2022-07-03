// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name_uppercase }}_ST_CFG_SV__
`define __UVME_{{ name_uppercase }}_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the {{ name_proper }} UVM Agent Self-Testing
 * Environment (uvme_{{ name }}_st_env_c) components.
 */
class uvme_{{ name }}_st_cfg_c extends uvml_cfg_c;

   /// @defgroup Integrals
   /// @{
   rand bit                      enabled              ; ///< Enables/disables all components' run_phase() execution
   rand uvm_{{ mode_1 }}_{{ mode_2 }}_enum  is_{{ mode_1 }}            ; ///< Controls #{{ mode_1 }}_cfg's setting of the same name
   rand bit                      scoreboarding_enabled; ///< Controls #sb_cfg's 'enabled' setting
   rand bit                      cov_model_enabled    ; ///< Enables/disables agents' functional coverage models.
   rand bit                      trn_log_enabled      ; ///< Enables/disables agents' transaction logging.
   /// @}

   /// @defgroup Objects
   /// @{
   rand uvma_{{ name }}_cfg_c  {{ mode_1 }}_cfg ; ///< Active agent configuration
   rand uvma_{{ name }}_cfg_c  {{ mode_2 }}_cfg; ///< Passive agent configuration
   rand uvml_sb_simplex_cfg_c  sb_cfg; ///< Scoreboard configuration
   /// @}


   `uvm_object_utils_begin(uvme_{{ name }}_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_{{ mode_1 }}_{{ mode_2 }}_enum, is_{{ mode_1 }}            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)

      `uvm_field_object({{ mode_1 }}_cfg , UVM_DEFAULT)
      `uvm_field_object({{ mode_2 }}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_cfg     , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, {{ mode_1 }} with scoreboarding and transaction logging enabled.
    */
   constraint defaults_cons {
      soft enabled                == 1;
      soft is_{{ mode_1 }}              == UVM_ACTIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }

   /**
    * Sets agents configuration.
    */
   constraint agent_cfg_cons {
      if (enabled) {
         {{ mode_1 }}_cfg .enabled == 1;
         {{ mode_2 }}_cfg.enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg .enabled == 0;
         {{ mode_2 }}_cfg.enabled == 0;
      }

      if (is_{{ mode_1 }} == UVM_ACTIVE) {
         {{ mode_1 }}_cfg .is_{{ mode_1 }} == UVM_ACTIVE ;
         {{ mode_2 }}_cfg.is_{{ mode_1 }} == UVM_PASSIVE;
      }
      else {
         {{ mode_1 }}_cfg .is_{{ mode_1 }} == UVM_PASSIVE;
         {{ mode_2 }}_cfg.is_{{ mode_1 }} == UVM_PASSIVE;
      }

      if (trn_log_enabled) {
         {{ mode_1 }}_cfg .trn_log_enabled == 1;
         {{ mode_2 }}_cfg.trn_log_enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg .trn_log_enabled == 0;
         {{ mode_2 }}_cfg.trn_log_enabled == 0;
      }

      if (cov_model_enabled) {
         {{ mode_1 }}_cfg .cov_model_enabled == 1;
         {{ mode_2 }}_cfg.cov_model_enabled == 1;
      }
      else {
         {{ mode_1 }}_cfg .cov_model_enabled == 0;
         {{ mode_2 }}_cfg.cov_model_enabled == 0;
      }
   }

   /**
    * Sets scoreboard (#sb_cfg) configuration.
    */
   constraint sb_cfg_cons {
      sb_cfg.mode == UVML_SB_MODE_IN_ORDER;
      if (scoreboarding_enabled) {
         sb_cfg.enabled == 1;
      }
      else {
         sb_cfg.enabled == 0;
      }
   }


   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_{{ name }}_st_cfg");

endclass : uvme_{{ name }}_st_cfg_c


function uvme_{{ name }}_st_cfg_c::new(string name="uvme_{{ name }}_st_cfg");

   super.new(name);

   {{ mode_1 }}_cfg  = uvma_{{ name }}_cfg_c::type_id::create("{{ mode_1 }}_cfg" );
   {{ mode_2 }}_cfg = uvma_{{ name }}_cfg_c::type_id::create("{{ mode_2 }}_cfg");
   sb_cfg      = uvml_sb_simplex_cfg_c::type_id::create("sb_cfg");

endfunction : new


`endif // __UVME_{{ name_uppercase }}_ST_CFG_SV__

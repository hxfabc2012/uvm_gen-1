// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_ST_CFG_SV__
`define __UVME_${name_uppercase}_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running ${name_normal_case} Self-Testing Environment (uvme_${name}_st_env_c) components.
 */
class uvme_${name}_st_cfg_c extends uvm_object;
   
   // Integrals
   rand bit                      enabled              ;
   rand uvm_active_passive_enum  is_active            ;
   rand bit                      scoreboarding_enabled;
   rand bit                      cov_model_enabled    ;
   rand bit                      trn_log_enabled      ;
   
   // Objects
   rand uvma_${name}_cfg_c  ${name_1}_cfg;
   rand uvma_${name}_cfg_c  ${name_2}_cfg;
   rand uvml_sb_simplex_cfg_c  sb_cfg;
   
   
   `uvm_object_utils_begin(uvme_${name}_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(${name_1}_cfg, UVM_DEFAULT)
      `uvm_field_object(${name_2}_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_cfg       , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }
   
   constraint agent_cfg_cons {
      if (enabled) {
         ${name_1}_cfg.enabled == 1;
         ${name_2}_cfg.enabled == 1;
      }
      else {
         ${name_1}_cfg.enabled == 0;
         ${name_2}_cfg.enabled == 0;
      }
      
      if (is_active == UVM_ACTIVE) {
         ${name_1}_cfg.is_active == UVM_ACTIVE;
         ${name_2}_cfg.is_active == UVM_ACTIVE;
      }
      else {
         ${name_1}_cfg.is_active == UVM_PASSIVE;
         ${name_2}_cfg.is_active == UVM_PASSIVE;
      }
      
      if (trn_log_enabled) {
         ${name_1}_cfg.trn_log_enabled == 1;
         ${name_2}_cfg.trn_log_enabled == 1;
      }
      else {
         ${name_1}_cfg.trn_log_enabled == 0;
         ${name_2}_cfg.trn_log_enabled == 0;
      }
      
      if (cov_model_enabled) {
         ${name_1}_cfg.cov_model_enabled == 1;
         ${name_2}_cfg.cov_model_enabled == 1;
      }
      else {
         ${name_1}_cfg.cov_model_enabled == 0;
         ${name_2}_cfg.cov_model_enabled == 0;
      }
   }
   
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
   extern function new(string name="uvme_${name}_st_cfg");
   
endclass : uvme_${name}_st_cfg_c


function uvme_${name}_st_cfg_c::new(string name="uvme_${name}_st_cfg");
   
   super.new(name);
   
   ${name_1}_cfg  = uvma_${name}_cfg_c::type_id::create("${name_1}_cfg");
   ${name_2}_cfg  = uvma_${name}_cfg_c::type_id::create("${name_2}_cfg");
   sb_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_cfg");
   
endfunction : new


`endif // __UVME_${name_uppercase}_ST_CFG_SV__

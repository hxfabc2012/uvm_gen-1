// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CFG_SV__
`define __UVME_${name_uppercase}_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the ${name_normal_case} Sub-System environment
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

   /// @defgroup Sub-system parameters
   /// @{
   rand longint unsigned  reg_block_base_address; ///< Base address for #${name}_reg_block
   rand int unsigned      ${clk_agent_name}_frequency; ///< Frequency for clock generation (Hz)
   /// @}

   // TODO: Add sub-environments configuration handles
   //       Ex: rand uvme_sub_env_cfg_c  sub_env_cfg; ///< Describe me!

   /// @defgroup Agent configuration handles
   /// @{
   rand uvma_clk_cfg_c    ${clk_agent_name}_cfg; ///< Clock agent configuration
   rand uvma_reset_cfg_c  ${reset_agent_name}_cfg; ///< Reset agent configuration
   rand uvma_${ral_agent_type}_cfg_c  ${ral_agent_name}_cfg; ///< Register access agent configuration
   /// @}

   /// @defgroup Objects
   /// @{
   rand uvme_${name}_reg_block_c  ${name}_reg_block; ///< Register block model
   // TODO Add scoreboard configuration handles
   //      Ex: rand uvml_sb_cfg_c  sb_egress_cfg ; ///< Describe me!
   //          rand uvml_sb_cfg_c  sb_ingress_cfg; ///< Describe me!
   /// @}


   `uvm_object_utils_begin(uvme_${name}_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)

      `uvm_field_int(reg_block_base_address, UVM_DEFAULT)
      `uvm_field_int(${clk_agent_name}_frequency, UVM_DEFAULT + UVM_DEC)

      // TODO: Add sub-environments configuration field macros
      //       Ex: `uvm_field_object(sub_env_cfg, UVM_DEFAULT)

      `uvm_field_object(${clk_agent_name}_cfg, UVM_DEFAULT)
      `uvm_field_object(${reset_agent_name}_cfg, UVM_DEFAULT)
      `uvm_field_object(${ral_agent_name}_cfg, UVM_DEFAULT)

      `uvm_field_object(${name}_reg_block, UVM_DEFAULT)
      // TODO Add scoreboard cfg field macros
      //      Ex: `uvm_field_object(sb_egress_cfg , UVM_DEFAULT)
      //          `uvm_field_object(sb_ingress_cfg, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Rules for safe default options: enabled, passive with scoreboarding and transaction logging enabled.
    */
   constraint defaults_cons {
      soft enabled                     == 0;
      soft is_active                   == UVM_PASSIVE;
      soft scoreboarding_enabled       == 1;
      soft cov_model_enabled           == 0;
      soft trn_log_enabled             == 1;
           reg_block_base_address      == uvme_${name}_default_reg_block_base_address;
           ${clk_agent_name}_frequency == uvme_${name}_default_${clk_agent_name}_frequency;
   }

   /**
    * Sets agents configuration.
    */
   constraint agent_cfg_cons {
      //${ral_agent_name}_cfg.reset_type == UVML_RESET_TYPE_SYNCHRONOUS;

      if (enabled) {
         ${clk_agent_name}_cfg.enabled == 1;
         ${reset_agent_name}_cfg.enabled == 1;
         ${ral_agent_name}_cfg.enabled == 1;
      }
      else {
         ${clk_agent_name}_cfg.enabled == 0;
         ${reset_agent_name}_cfg.enabled == 0;
         ${ral_agent_name}_cfg.enabled == 0;
      }

      if (is_active == UVM_ACTIVE) {
         ${clk_agent_name}_cfg.is_active == UVM_ACTIVE;
         ${reset_agent_name}_cfg.is_active == UVM_ACTIVE;
         ${ral_agent_name}_cfg.is_active == UVM_ACTIVE;
      }
      else {
         ${clk_agent_name}_cfg.is_active == UVM_PASSIVE;
         ${reset_agent_name}_cfg.is_active == UVM_PASSIVE;
         ${ral_agent_name}_cfg.is_active == UVM_PASSIVE;
      }

      if (trn_log_enabled) {
         ${clk_agent_name}_cfg.trn_log_enabled == 1;
         ${reset_agent_name}_cfg.trn_log_enabled == 1;
         ${ral_agent_name}_cfg.trn_log_enabled == 1;
      }
      else {
         ${clk_agent_name}_cfg.trn_log_enabled == 0;
         ${reset_agent_name}_cfg.trn_log_enabled == 0;
         ${ral_agent_name}_cfg.trn_log_enabled == 0;
      }
   }


   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_${name}_cfg");

endclass : uvme_${name}_cfg_c


function uvme_${name}_cfg_c::new(string name="uvme_${name}_cfg");

   super.new(name);

   // TODO Create sub-environment cfg objects
   //      Ex: sub_env_cfg  = uvme_sub_env_cfg_c::type_id::create("sub_env_cfg");

   ${clk_agent_name}_cfg = uvma_clk_cfg_c::type_id::create("${clk_agent_name}_cfg");
   ${reset_agent_name}_cfg = uvma_reset_cfg_c::type_id::create("${reset_agent_name}_cfg");
   ${ral_agent_name}_cfg = uvma_${ral_agent_type}_cfg_c::type_id::create("${ral_agent_name}_cfg");

   ${name}_reg_block = uvme_${name}_reg_block_c::type_id::create("${name}_reg_block");
   ${name}_reg_block.cfg = this;
   ${name}_reg_block.build();

   // TODO Create scoreboard cfg objects
   //      Ex: sb_egress_cfg  = uvml_sb_cfg_c::type_id::create("sb_egress_cfg" );
   //          sb_ingress_cfg = uvml_sb_cfg_c::type_id::create("sb_ingress_cfg");

endfunction : new


`endif // __UVME_${name_uppercase}_CFG_SV__

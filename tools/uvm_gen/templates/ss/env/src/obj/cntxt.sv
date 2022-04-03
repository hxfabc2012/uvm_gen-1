// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CNTXT_SV__
`define __UVME_${name_uppercase}_CNTXT_SV__


/**
 * Object encapsulating all state variables for ${name_normal_case} Sub-System environment (uvme_${name}_env_c) components.
 */
class uvme_${name}_cntxt_c extends uvml_cntxt_c;

   /// @defgroup Integrals
   /// @{
   uvml_reset_state_enum  reset_state = UVML_RESET_STATE_PRE_RESET; ///< Predicted Pre/In/Post reset state of the DUT
   /// @}

   /// @defgroup Sub-environments
   /// @{
   // TODO Add sub-environments context handles
   //      Ex: uvme_sub_env_cntxt_c  sub_env_cntxt; ///< Describe me!
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_clk_cntxt_c  ${clk_agent_name}_cntxt; ///< Clock agent context
   uvma_reset_cntxt_c  ${reset_agent_name}_cntxt; ///< Reset agent context
   uvma_${ral_agent_type}_cntxt_c  ${ral_agent_name}_cntxt; ///< Register access agent content
   /// @}

   /// @defgroup Objects
   /// @{
   uvm_event  sample_cfg_e  ; ///< Triggers sampling of environment configuration by the functional coverage model.
   uvm_event  sample_cntxt_e; ///< Triggers sampling of environment context by the functional coverage model.
   // TODO Add scoreboard context handles
   //      Ex: uvml_sb_simplex_cntxt_c  sb_egress_cntxt ; ///< Describe me!
   //          uvml_sb_simplex_cntxt_c  sb_ingress_cntxt; ///< Describe me!
   /// @}


   `uvm_object_utils_begin(uvme_${name}_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)

       // TODO: Add sub-environments context field macros
       //       Ex: `uvm_field_object(sub_env_cntxt, UVM_DEFAULT)

      `uvm_field_object(${clk_agent_name}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${reset_agent_name}_cntxt, UVM_DEFAULT)
      `uvm_field_object(${ral_agent_name}_cntxt, UVM_DEFAULT)

      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
      // TODO Add scoreboard context field macros
      //      Ex: `uvm_field_object(sb_egress_cntxt , UVM_DEFAULT)
      //          `uvm_field_object(sb_ingress_cntxt, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_${name}_cntxt");


   /**
    * Returns all state variables to initial values.
    */
   extern function void reset();

endclass : uvme_${name}_cntxt_c


function uvme_${name}_cntxt_c::new(string name="uvme_${name}_cntxt");

   super.new(name);

   // TODO Create environment cntxt objects
   //      Ex: sub_env_cntxt  = uvme_sub_env_cntxt_c::type_id::create("sub_env_cntxt");

   ${clk_agent_name}_cntxt = uvma_reset_cntxt_c::type_id::create("${clk_agent_name}_cntxt");
   ${reset_agent_name}_cntxt = uvma_reset_cntxt_c::type_id::create("${reset_agent_name}_cntxt");
   ${ral_agent_name}_cntxt = uvma_${ral_agent_type}_cntxt_c::type_id::create("${ral_agent_name}_cntxt");

   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   // TODO Create uvme_${name}_cntxt_c scoreboard context objects
   //      Ex: sb_egress_cntxt  = uvml_sb_simplex_cntxt_c::type_id::create("sb_egress_cntxt" );
   //          sb_ingress_cntxt = uvml_sb_simplex_cntxt_c::type_id::create("sb_ingress_cntxt");

endfunction : new


function void uvme_${name}_cntxt_c::reset();



endfunction : reset


`endif // __UVME_${name_uppercase}_CNTXT_SV__

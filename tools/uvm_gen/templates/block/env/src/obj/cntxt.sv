// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CNTXT_SV__
`define __UVME_${name_uppercase}_CNTXT_SV__


/**
 * Object encapsulating all state variables for ${name_normal_case} Block environment (uvme_${name}_env_c) components.
 */
class uvme_${name}_cntxt_c extends uvml_cntxt_c;

   /// @defgroup Integrals
   /// @{
   uvml_reset_state_enum  reset_state = UVML_RESET_STATE_PRE_RESET; ///< Predicted Pre/In/Post reset state of the DUT
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_clk_cntxt_c    clk_cntxt  ; ///< Clock agent context
   uvma_reset_cntxt_c  reset_cntxt; ///< Reset agent context
   uvma_${name}_cp_cntxt_c      cp_cntxt    ; ///< Control plane agent content
   uvma_${name}_dp_in_cntxt_c   dp_in_cntxt ; ///< Data plane input agent content
   uvma_${name}_dp_out_cntxt_c  dp_out_cntxt; ///< Data plane output agent content
   /// @}

   /// @defgroup Objects
   /// @{
   uvml_sb_simplex_cntxt_c  sb_dp_cntxt   ; ///< Data path scoreboard context
   uvm_event                sample_cfg_e  ; ///< Triggers sampling of environment configuration by the functional coverage model.
   uvm_event                sample_cntxt_e; ///< Triggers sampling of environment context by the functional coverage model.
   /// @}


   `uvm_object_utils_begin(uvme_${name}_cntxt_c)
      `uvm_field_object(clk_cntxt   , UVM_DEFAULT)
      `uvm_field_object(reset_cntxt , UVM_DEFAULT)
      `uvm_field_object(cp_cntxt    , UVM_DEFAULT)
      `uvm_field_object(dp_in_cntxt , UVM_DEFAULT)
      `uvm_field_object(dp_out_cntxt, UVM_DEFAULT)

      `uvm_field_object(sb_dp_cntxt   , UVM_DEFAULT)
      `uvm_field_event (sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event (sample_cntxt_e, UVM_DEFAULT)
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

   clk_cntxt    = uvma_clk_cntxt_c  ::type_id::create("clk_cntxt"  );
   reset_cntxt  = uvma_reset_cntxt_c::type_id::create("reset_cntxt");
   cp_cntxt     = uvma_${name}_cp_cntxt_c    ::type_id::create("cp_cntxt"    );
   dp_in_cntxt  = uvma_${name}_dp_in_cntxt_c ::type_id::create("dp_in_cntxt" );
   dp_out_cntxt = uvma_${name}_dp_out_cntxt_c::type_id::create("dp_out_cntxt");

   sb_dp_cntxt = uvml_sb_simplex_cntxt_c::type_id::create("sb_dp_cntxt");
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");

endfunction : new


function void uvme_${name}_cntxt_c::reset();



endfunction : reset


`endif // __UVME_${name_uppercase}_CNTXT_SV__

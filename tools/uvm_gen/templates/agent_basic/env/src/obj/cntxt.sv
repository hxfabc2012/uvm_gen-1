// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_CNTXT_SV__
`define __UVME_${name_uppercase}_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for ${name_normal_case} UVM Agent Self-Test Environment (uvme_${name}_st_env_c) components.
 */
class uvme_${name}_st_cntxt_c extends uvm_object;

   /// @defgroup Objects
   /// @{
   uvma_${name}_cntxt_c  active_cntxt ; ///< Active agent context handle
   uvma_${name}_cntxt_c  passive_cntxt; ///< Passive agent context handle
   uvml_sb_simplex_cntxt_c  sb_cntxt; ///< Scoreboard context handle
   /// @}


   `uvm_object_utils_begin(uvme_${name}_st_cntxt_c)
      `uvm_field_object(active_cntxt , UVM_DEFAULT)
      `uvm_field_object(passive_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_cntxt     , UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Creates sub-context objects.
    */
   extern function new(string name="uvme_${name}_st_cntxt");

   /**
    * Forces all sub-context objects to reset.
    */
   extern function void reset();

endclass : uvme_${name}_st_cntxt_c


function uvme_${name}_st_cntxt_c::new(string name="uvme_${name}_st_cntxt");

   super.new(name);

   active_cntxt  = uvma_${name}_cntxt_c::type_id::create("active_cntxt" );
   passive_cntxt = uvma_${name}_cntxt_c::type_id::create("passive_cntxt");
   sb_cntxt      = uvml_sb_simplex_cntxt_c::type_id::create("sb_cntxt");

endfunction : new


function void uvme_${name}_st_cntxt_c::reset();

   active_cntxt .reset();
   passive_cntxt.reset();

endfunction : reset


`endif // __UVME_${name_uppercase}_ST_CNTXT_SV__

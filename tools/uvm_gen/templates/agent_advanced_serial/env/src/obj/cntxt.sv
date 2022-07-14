// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_CNTXT_SV__
`define __UVME_{{ upper(name) }}_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for {{ full_name }}  Self-Testing environment (uvme_{{ name }}_st_env_c) components.
 */
class uvme_{{ name }}_st_cntxt_c extends uvml_cntxt_c;

   // Agent context handles
   uvma_{{ name }}_cntxt_c  {{ mode_1 }}_cntxt; ///<
   uvma_{{ name }}_cntxt_c  {{ mode_2 }}_cntxt; ///<

   // Scoreboard context handle
   uvml_sb_simplex_cntxt_c  sb_tx_cntxt; ///<
   uvml_sb_simplex_cntxt_c  sb_rx_cntxt; ///<

   // Events
   uvm_event  sample_cfg_e  ; ///<
   uvm_event  sample_cntxt_e; ///<


   `uvm_object_utils_begin(uvme_{{ name }}_st_cntxt_c)
      `uvm_field_object({{ mode_1 }}_cntxt, UVM_DEFAULT)
      `uvm_field_object({{ mode_2 }}_cntxt, UVM_DEFAULT)

      `uvm_field_object(sb_tx_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_rx_cntxt, UVM_DEFAULT)

      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_{{ name }}_st_cntxt");

   /**
    * TODO Describe uvme_{{ name }}_st_cntxt_c::reset()
    */
   extern function void reset();

endclass : uvme_{{ name }}_st_cntxt_c


function uvme_{{ name }}_st_cntxt_c::new(string name="uvme_{{ name }}_st_cntxt");

   super.new(name);

   {{ mode_1 }}_cntxt   = uvma_{{ name }}_cntxt_c    ::type_id::create("{{ mode_1 }}_cntxt"  );
   {{ mode_2 }}_cntxt   = uvma_{{ name }}_cntxt_c    ::type_id::create("{{ mode_2 }}_cntxt"  );
   sb_tx_cntxt = uvml_sb_simplex_cntxt_c::type_id::create("sb_tx_cntxt");
   sb_rx_cntxt = uvml_sb_simplex_cntxt_c::type_id::create("sb_rx_cntxt");

   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");

endfunction : new


function void uvme_{{ name }}_st_cntxt_c::reset();

   {{ mode_1 }}_cntxt.reset();
   {{ mode_2 }}_cntxt.reset();

endfunction : reset


`endif // __UVME_{{ upper(name) }}_ST_CNTXT_SV__

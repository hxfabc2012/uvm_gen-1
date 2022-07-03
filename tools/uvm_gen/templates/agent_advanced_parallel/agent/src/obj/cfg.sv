// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_CFG_SV__
`define __UVMA_{{ upper(name) }}_CFG_SV__


// Default sequences
typedef class uvma_{{ name }}_mon_vseq_c ;
typedef class uvma_{{ name }}_idle_vseq_c;
typedef class uvma_{{ name }}_mstr_drv_vseq_c;
typedef class uvma_{{ name }}_slv_drv_vseq_c ;


/**
 * Object encapsulating all parameters for creating, connecting and running all {{ full_name }} agent
 * (uvma_{{ name }}_agent_c) components.
 */
class uvma_{{ name }}_cfg_c extends uvm_object;
   
   // Generic options
   rand bit                      enabled          ; ///< TODO Describe uvma_{{ name }}_cfg_c::enabled
   rand bit                      bypass_mode      ; ///< 
   rand uvm_active_passive_enum  is_active        ; ///< TODO Describe uvma_{{ name }}_cfg_c::is_active
   rand uvml_reset_type_enum     reset_type       ; ///< TODO Describe uvma_{{ name }}_cfg_c::reset_type
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< TODO Describe uvma_{{ name }}_cfg_c::sqr_arb_mode
   rand bit                      cov_model_enabled; ///< TODO Describe uvma_{{ name }}_cfg_c::cov_model_enabled
   rand bit                      trn_log_enabled  ; ///< TODO Describe uvma_{{ name }}_cfg_c::trn_log_enabled
   
   // Protocol Options
   rand uvma_{{ name }}_version_enum   version    ; ///< TODO Describe uvma_{{ name }}_cfg_c::version
   rand uvma_{{ name }}_mode_enum      drv_mode   ; ///< TODO Describe uvma_{{ name }}_cfg_c::drv_mode
   rand uvma_{{ name }}_drv_idle_enum  drv_idle   ; ///< TODO Describe uvma_{{ name }}_cfg_c::drv_idle
   rand int unsigned            addr_width ; ///< TODO Describe uvma_{{ name }}_cfg_c::addr_width
   rand int unsigned            data_width ; ///< TODO Describe uvma_{{ name }}_cfg_c::data_width
   rand int unsigned            auser_width; ///< TODO Describe uvma_{{ name }}_cfg_c::auser_width
   rand int unsigned            wuser_width; ///< TODO Describe uvma_{{ name }}_cfg_c::wuser_width
   rand int unsigned            ruser_width; ///< TODO Describe uvma_{{ name }}_cfg_c::ruser_width
   rand int unsigned            achk_width ; ///< TODO Describe uvma_{{ name }}_cfg_c::achk_width
   rand int unsigned            rchk_width ; ///< TODO Describe uvma_{{ name }}_cfg_c::rchk_width
   rand int unsigned            id_width   ; ///< TODO Describe uvma_{{ name }}_cfg_c::id_width
   
   // Sequence Types
   uvm_object_wrapper  mon_vseq_type     ; ///< TODO Describe uvma_{{ name }}_cfg_c::mon_vseq_type
   uvm_object_wrapper  idle_vseq_type    ; ///< TODO Describe uvma_{{ name }}_cfg_c::idle_vseq_type
   uvm_object_wrapper  mstr_drv_vseq_type; ///< TODO Describe uvma_{{ name }}_cfg_c::mstr_drv_vseq_type
   uvm_object_wrapper  slv_drv_vseq_type ; ///< TODO Describe uvma_{{ name }}_cfg_c::slv_drv_vseq_type
   
   
   `uvm_object_utils_begin(uvma_{{ name }}_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
      
      `uvm_field_enum(uvma_{{ name }}_version_enum , version    , UVM_DEFAULT          )
      `uvm_field_enum(uvma_{{ name }}_mode_enum    , drv_mode   , UVM_DEFAULT          )
      `uvm_field_enum(uvma_{{ name }}_drv_idle_enum, drv_idle   , UVM_DEFAULT          )
      `uvm_field_int (                        addr_width , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        data_width , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        auser_width, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        wuser_width, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        ruser_width, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        achk_width , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        rchk_width , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                        id_width   , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft reset_type        == UVML_RESET_TYPE_SYNCHRONOUS;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
      
      soft version     == UVMA_{{ upper(name) }}_VERSION_1P2;
      soft drv_idle    == UVMA_{{ upper(name) }}_DRV_IDLE_ZEROS;
      soft auser_width == uvma_{{ name }}_default_auser_width;
      soft wuser_width == uvma_{{ name }}_default_wuser_width;
      soft ruser_width == uvma_{{ name }}_default_ruser_width;
      soft addr_width  == uvma_{{ name }}_default_addr_width ;
      soft data_width  == uvma_{{ name }}_default_data_width ;
      soft id_width    == uvma_{{ name }}_default_id_width   ;
      soft achk_width  == uvma_{{ name }}_default_achk_width ;
      soft rchk_width  == uvma_{{ name }}_default_rchk_width ;
   }
   
   constraint limits_cons {
      data_width % 8 == 0;
      data_width  inside {[8:`UVMA_{{ upper(name) }}_DATA_MAX_WIDTH ]};
      id_width    inside {[0:`UVMA_{{ upper(name) }}_ID_MAX_WIDTH   ]};
      auser_width inside {[0:`UVMA_{{ upper(name) }}_AUSER_MAX_WIDTH]};
      wuser_width inside {[0:`UVMA_{{ upper(name) }}_WUSER_MAX_WIDTH]};
      ruser_width inside {[0:`UVMA_{{ upper(name) }}_RUSER_MAX_WIDTH]};
      addr_width  inside {[1:`UVMA_{{ upper(name) }}_ADDR_MAX_WIDTH ]};
      achk_width  inside {[0:`UVMA_{{ upper(name) }}_ACHK_MAX_WIDTH ]};
      rchk_width  inside {[0:`UVMA_{{ upper(name) }}_RCHK_MAX_WIDTH ]};
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_cfg");
   
endclass : uvma_{{ name }}_cfg_c


function uvma_{{ name }}_cfg_c::new(string name="uvma_{{ name }}_cfg");
   
   super.new(name);
   mon_vseq_type      = uvma_{{ name }}_mon_vseq_c     ::get_type();
   idle_vseq_type     = uvma_{{ name }}_idle_vseq_c    ::get_type();
   mstr_drv_vseq_type = uvma_{{ name }}_mstr_drv_vseq_c::get_type();
   slv_drv_vseq_type  = uvma_{{ name }}_slv_drv_vseq_c ::get_type();
   
endfunction : new


`endif // __UVMA_{{ upper(name) }}_CFG_SV__

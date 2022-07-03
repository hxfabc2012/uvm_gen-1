// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_LOGGER_SV__
`define __UVMA_{{ upper(name) }}_LOGGER_SV__


/**
 * TODO Describe uvma_{{ name }}_logger_c
 */
class uvma_{{ name }}_logger_c extends uvm_component;
   
   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   
   // Components
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c    )  {{ tx }}_mon_frame_logger; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c    )  {{ rx }}_mon_frame_logger; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_mon_trn_logger  ; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_mon_trn_logger  ; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c   )  seq_item_logger    ; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_seq_item_logger ; ///< 
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_seq_item_logger ; ///< 
   
   // TLM
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ tx }}_export ; ///< TODO Rename this
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ rx }}_export ; ///< TODO Rename this
   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_mon_trn_export ; ///< 
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_mon_trn_export ; ///< 
   uvm_analysis_export #(uvma_{{ name }}_seq_item_c   )  seq_item_export   ; ///< 
   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_seq_item_export; ///< 
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_seq_item_export; ///< 
   
   
   `uvm_component_utils_begin(uvma_{{ name }}_logger_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_logger", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_{{ name }}_logger_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_{{ name }}_logger_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_{{ name }}_logger_c


function uvma_{{ name }}_logger_c::new(string name="uvma_{{ name }}_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_{{ name }}_logger_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Create components
   {{ tx }}_mon_frame_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c    )::type_id::create("{{ tx }}_mon_frame_logger", this);
   {{ rx }}_mon_frame_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c    )::type_id::create("{{ rx }}_mon_frame_logger", this);
   {{ tx }}_mon_trn_logger   = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_mon_trn_c )::type_id::create("{{ tx }}_mon_trn_logger"  , this);
   {{ rx }}_mon_trn_logger   = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_mon_trn_c )::type_id::create("{{ rx }}_mon_trn_logger"  , this);
   seq_item_logger     = uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c   )::type_id::create("seq_item_logger"    , this);
   {{ tx }}_seq_item_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_seq_item_c)::type_id::create("{{ tx }}_seq_item_logger" , this);
   {{ rx }}_seq_item_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_seq_item_c)::type_id::create("{{ rx }}_seq_item_logger" , this);
   
endfunction : build_phase


function void uvma_{{ name }}_logger_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   {{ tx }}_mon_frame_logger.set_file_name({get_parent().get_full_name(), ".tx.mon_frame" });
   {{ rx }}_mon_frame_logger.set_file_name({get_parent().get_full_name(), ".rx.mon_frame" });
   {{ tx }}_mon_trn_logger  .set_file_name({get_parent().get_full_name(), ".tx.mon_trn" });
   {{ rx }}_mon_trn_logger  .set_file_name({get_parent().get_full_name(), ".rx.mon_trn" });
   seq_item_logger    .set_file_name({get_parent().get_full_name(), ".seq_item"   });
   {{ tx }}_seq_item_logger .set_file_name({get_parent().get_full_name(), ".tx.seq_item"});
   {{ rx }}_seq_item_logger .set_file_name({get_parent().get_full_name(), ".rx.seq_item"});
   
   mon_trn_{{ tx }}_export  = {{ tx }}_mon_frame_logger.analysis_export;
   mon_trn_{{ rx }}_export  = {{ rx }}_mon_frame_logger.analysis_export;
   {{ tx }}_mon_trn_export  = {{ tx }}_mon_trn_logger  .analysis_export;
   {{ rx }}_mon_trn_export  = {{ rx }}_mon_trn_logger  .analysis_export;
   seq_item_export    = seq_item_logger    .analysis_export;
   {{ tx }}_seq_item_export = {{ tx }}_seq_item_logger .analysis_export;
   {{ rx }}_seq_item_export = {{ rx }}_seq_item_logger .analysis_export;
   
endfunction : connect_phase


`endif // __UVMA_{{ upper(name) }}_LOGGER_SV__

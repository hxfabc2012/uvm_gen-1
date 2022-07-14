// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_LOGGER_SV__
`define __UVMA_{{ upper(name) }}_LOGGER_SV__


/**
 * TODO Describe uvma_{{ name }}_logger_c
 */
class uvma_{{ name }}_logger_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup Components
   /// @{
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c)  seq_item_logger; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c )  tx_mon_trn_logger; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c )  rx_mon_trn_logger; ///<
{% if symmetric %}   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)  tx_phy_seq_item_logger ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)  rx_phy_seq_item_logger ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )  tx_phy_mon_trn_logger  ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )  rx_phy_mon_trn_logger  ; ///<
{% else %}   uvml_logs_metadata_logger_c #(uvma_{{ name }}_tx_seq_item_c)  tx_phy_seq_item_logger ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_rx_seq_item_c)  rx_phy_seq_item_logger ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_tx_mon_trn_c )  tx_phy_mon_trn_logger  ; ///<
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_rx_mon_trn_c )  rx_phy_mon_trn_logger  ; ///<
{% endif %}   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_export #(uvma_{{ name }}_seq_item_c)  seq_item_export   ; ///<
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  tx_mon_trn_export ; ///< TODO Rename this
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  rx_mon_trn_export ; ///< TODO Rename this
{% if symmetric %}   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  tx_phy_seq_item_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  rx_phy_seq_item_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  tx_phy_mon_trn_export ; ///<
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  rx_phy_mon_trn_export ; ///<
{% else %}   uvm_analysis_export #(uvma_{{ name }}_tx_seq_item_c)  tx_phy_seq_item_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_rx_seq_item_c)  rx_phy_seq_item_export; ///<
   uvm_analysis_export #(uvma_{{ name }}_tx_mon_trn_c )  tx_phy_mon_trn_export ; ///<
   uvm_analysis_export #(uvma_{{ name }}_rx_mon_trn_c )  rx_phy_mon_trn_export ; ///<
{% endif %}   /// @}


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

   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_cntxt();

   /**
    *
    */
   extern function void create_components();

   /**
    *
    */
   extern function void configure_loggers();

   /**
    *
    */
   extern function void connect_loggers();

endclass : uvma_{{ name }}_logger_c


function uvma_{{ name }}_logger_c::new(string name="uvma_{{ name }}_logger", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_logger_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg  ();
   get_cntxt();
   create_components();

endfunction : build_phase


function void uvma_{{ name }}_logger_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   configure_loggers();
   connect_loggers  ();

endfunction : connect_phase


function void uvma_{{ name }}_logger_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_LOGGER", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_logger_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_LOGGER", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_logger_c::create_components();

   seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c)::type_id::create("seq_item_logger", this);
   tx_mon_trn_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c)::type_id::create("tx_mon_trn_logger", this);
   rx_mon_trn_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c)::type_id::create("rx_mon_trn_logger", this);
{% if symmetric %}   tx_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)::type_id::create("tx_phy_seq_item_logger", this);
   rx_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)::type_id::create("rx_phy_seq_item_logger", this);
   tx_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )::type_id::create("tx_phy_mon_trn_logger" , this);
   rx_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )::type_id::create("rx_phy_mon_trn_logger" , this);
{% else %}   tx_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_tx_seq_item_c)::type_id::create("tx_phy_seq_item_logger", this);
   rx_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_rx_seq_item_c)::type_id::create("rx_phy_seq_item_logger", this);
   tx_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_tx_mon_trn_c )::type_id::create("tx_phy_mon_trn_logger" , this);
   rx_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_rx_mon_trn_c )::type_id::create("rx_phy_mon_trn_logger" , this);
{% endif %}
endfunction : create_components


function void uvma_{{ name }}_logger_c::configure_loggers();

   seq_item_logger.set_file_name({get_parent().get_full_name(), ".seq_item"});
   tx_mon_trn_logger     .set_file_name({get_parent().get_full_name(), ".tx_mon_trn"     });
   rx_mon_trn_logger     .set_file_name({get_parent().get_full_name(), ".rx_mon_trn"     });
   tx_phy_seq_item_logger.set_file_name({get_parent().get_full_name(), ".tx_phy_seq_item"});
   rx_phy_seq_item_logger.set_file_name({get_parent().get_full_name(), ".rx_phy_seq_item"});
   tx_phy_mon_trn_logger .set_file_name({get_parent().get_full_name(), ".tx_phy_mon_trn" });
   rx_phy_mon_trn_logger .set_file_name({get_parent().get_full_name(), ".rx_phy_mon_trn" });

endfunction : configure_loggers


function void uvma_{{ name }}_logger_c::connect_loggers();

   seq_item_export = seq_item_logger.analysis_export;
   tx_mon_trn_export      = tx_mon_trn_logger     .analysis_export;
   rx_mon_trn_export      = rx_mon_trn_logger     .analysis_export;
   tx_phy_seq_item_export = tx_phy_seq_item_logger.analysis_export;
   rx_phy_seq_item_export = rx_phy_seq_item_logger.analysis_export;
   tx_phy_mon_trn_export  = tx_phy_mon_trn_logger .analysis_export;
   rx_phy_mon_trn_export  = rx_phy_mon_trn_logger .analysis_export;

endfunction : connect_loggers


`endif // __UVMA_{{ upper(name) }}_LOGGER_SV__

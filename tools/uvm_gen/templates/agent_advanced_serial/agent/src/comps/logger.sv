// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_LOGGER_SV__
`define __UVMA_{{ name.upper() }}_LOGGER_SV__


/**
 * Component which logs to disk information of the transactions generated and monitored by uvma_{{ name }}_agent_c.
 */
class uvma_{{ name }}_logger_c extends uvm_component;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup Components
   /// @{
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c)  seq_item_logger; ///< Logs DATA Sequence Items from vsequencer.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_mon_trn_logger; ///< Logs {{ tx.upper() }} DATA Monitor Transactions from vsequencer.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_mon_trn_logger; ///< Logs {{ rx.upper() }} DATA Monitor Transactions from vsequencer.
{% if symmetric %}   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_phy_seq_item_logger ; ///< Logs Phy Sequence Items from {{ tx.upper() }} Driver.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_phy_seq_item_logger ; ///< Logs Phy Sequence Items from {{ rx.upper() }} Driver.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )  {{ tx }}_phy_mon_trn_logger  ; ///< Logs {{ tx.upper() }} Phy Monitor Transactions from Monitor.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )  {{ rx }}_phy_mon_trn_logger  ; ///< Logs {{ rx.upper() }} Phy Monitor Transactions from Monitor.
{% else %}   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_phy_seq_item_logger ; ///< Logs Phy Sequence Items from {{ tx.upper() }} Driver.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_phy_seq_item_logger ; ///< Logs Phy Sequence Items from {{ rx.upper() }} Driver.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_phy_mon_trn_logger  ; ///< Logs {{ tx.upper() }} Phy Monitor Transactions from Monitor.
   uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_phy_mon_trn_logger  ; ///< Logs {{ rx.upper() }} Phy Monitor Transactions from Monitor.
{% endif %}   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_export #(uvma_{{ name }}_seq_item_c)  seq_item_export   ; ///< Port for #seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_mon_trn_export ; ///< Port for #seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_mon_trn_export ; ///< Port for #seq_item_logger.
{% if symmetric %}   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_phy_seq_item_export; ///< Port for #{{ tx }}_phy_seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_phy_seq_item_export; ///< Port for #{{ rx }}_phy_seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  {{ tx }}_phy_mon_trn_export ; ///< Port for #{{ tx }}_phy_mon_trn_logger.
   uvm_analysis_export #(uvma_{{ name }}_phy_mon_trn_c )  {{ rx }}_phy_mon_trn_export ; ///< Port for #{{ rx }}_phy_mon_trn_logger.
{% else %}   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_phy_seq_item_export; ///< Port for #{{ tx }}_phy_seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_phy_seq_item_export; ///< Port for #{{ rx }}_phy_seq_item_logger.
   uvm_analysis_export #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_phy_mon_trn_export ; ///< Port for #{{ tx }}_phy_mon_trn_logger.
   uvm_analysis_export #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_phy_mon_trn_export ; ///< Port for #{{ rx }}_phy_mon_trn_logger.
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
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Builds loggers.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Connects TLM ports.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Creates logger components.
    */
   extern function void create_components();

   /**
    * Sets filenames for logger components.
    */
   extern function void configure_loggers();

   /**
    * Connects TLM ports to logger components.
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
      `uvm_fatal("{{ name.upper() }}_LOGGER", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_logger_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_LOGGER", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_logger_c::create_components();

   seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_seq_item_c)::type_id::create("seq_item_logger", this);
   {{ tx }}_mon_trn_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c)::type_id::create("{{ tx }}_mon_trn_logger", this);
   {{ rx }}_mon_trn_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_mon_trn_c)::type_id::create("{{ rx }}_mon_trn_logger", this);
{% if symmetric %}   {{ tx }}_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)::type_id::create("{{ tx }}_phy_seq_item_logger", this);
   {{ rx }}_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_seq_item_c)::type_id::create("{{ rx }}_phy_seq_item_logger", this);
   {{ tx }}_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )::type_id::create("{{ tx }}_phy_mon_trn_logger" , this);
   {{ rx }}_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_phy_mon_trn_c )::type_id::create("{{ rx }}_phy_mon_trn_logger" , this);
{% else %}   {{ tx }}_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_seq_item_c)::type_id::create("{{ tx }}_phy_seq_item_logger", this);
   {{ rx }}_phy_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_seq_item_c)::type_id::create("{{ rx }}_phy_seq_item_logger", this);
   {{ tx }}_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ tx }}_mon_trn_c )::type_id::create("{{ tx }}_phy_mon_trn_logger" , this);
   {{ rx }}_phy_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_{{ name }}_{{ rx }}_mon_trn_c )::type_id::create("{{ rx }}_phy_mon_trn_logger" , this);
{% endif %}
endfunction : create_components


function void uvma_{{ name }}_logger_c::configure_loggers();

   seq_item_logger.set_file_name({get_parent().get_full_name(), ".seq_item"});
   {{ tx }}_mon_trn_logger     .set_file_name({get_parent().get_full_name(), ".{{ tx }}_mon_trn"     });
   {{ rx }}_mon_trn_logger     .set_file_name({get_parent().get_full_name(), ".{{ rx }}_mon_trn"     });
   {{ tx }}_phy_seq_item_logger.set_file_name({get_parent().get_full_name(), ".{{ tx }}_phy_seq_item"});
   {{ rx }}_phy_seq_item_logger.set_file_name({get_parent().get_full_name(), ".{{ rx }}_phy_seq_item"});
   {{ tx }}_phy_mon_trn_logger .set_file_name({get_parent().get_full_name(), ".{{ tx }}_phy_mon_trn" });
   {{ rx }}_phy_mon_trn_logger .set_file_name({get_parent().get_full_name(), ".{{ rx }}_phy_mon_trn" });

endfunction : configure_loggers


function void uvma_{{ name }}_logger_c::connect_loggers();

   seq_item_export = seq_item_logger.analysis_export;
   {{ tx }}_mon_trn_export      = {{ tx }}_mon_trn_logger     .analysis_export;
   {{ rx }}_mon_trn_export      = {{ rx }}_mon_trn_logger     .analysis_export;
   {{ tx }}_phy_seq_item_export = {{ tx }}_phy_seq_item_logger.analysis_export;
   {{ rx }}_phy_seq_item_export = {{ rx }}_phy_seq_item_logger.analysis_export;
   {{ tx }}_phy_mon_trn_export  = {{ tx }}_phy_mon_trn_logger .analysis_export;
   {{ rx }}_phy_mon_trn_export  = {{ rx }}_phy_mon_trn_logger .analysis_export;

endfunction : connect_loggers


`endif // __UVMA_{{ name.upper() }}_LOGGER_SV__

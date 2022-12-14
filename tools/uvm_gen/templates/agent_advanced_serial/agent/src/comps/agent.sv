// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_AGENT_SV__
`define __UVMA_{{ name.upper() }}_AGENT_SV__


/**
 * Top-level component that encapsulates, builds and connects all others.  Capable of driving/monitoring the {{ full_name }}.
 */
class uvma_{{ name }}_agent_c extends uvml_agent_c;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Configuration handle.  Must be provided by component instantiating this Agent.
   uvma_{{ name }}_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this Agent.
   /// @}

   /// @defgroup Components
   /// @{
   uvma_{{ name }}_vsqr_c       vsequencer; ///< Provides sequence items for #driver.
   uvma_{{ name }}_drv_c        driver    ; ///< Drives Virtual Interface (uvma_{{ name }}_if) with stimulus obtained from #sequencer.
   uvma_{{ name }}_mon_c        monitor   ; ///< Samples transactions from Virtual Interface (uvma_{{ name }}_if).
   uvma_{{ name }}_cov_model_c  cov_model ; ///< Functional coverage model sampling #cfg, #cntxt and all transactions.
   uvma_{{ name }}_logger_c     logger    ; ///< Transaction logger for #vsequencer, #driver and #monitor.
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_seq_item_pull_port #(uvm_sequence_item)  upstream_sqr_port; ///< Upstream Sequencer Port for transport sequences.
   uvm_analysis_port  #(uvma_{{ name }}_seq_item_c)  seq_item_ap  ; ///< Port outputting DATA Sequence Items.
   uvm_analysis_port  #(uvma_{{ name }}_mon_trn_c )  {{ tx }}_mon_trn_ap; ///< Port outputting {{ tx.upper() }} Monitor Transactions.
   uvm_analysis_port  #(uvma_{{ name }}_mon_trn_c )  {{ rx }}_mon_trn_ap; ///< Port outputting {{ rx.upper() }} Monitor Transactions.
{% if symmetric %}   uvm_analysis_port  #(uvma_{{ name }}_phy_seq_item_c)  {{ tx }}_phy_seq_item_ap; ///< Port outputting {{ tx.upper() }} Phy Sequence Items from #driver.
   uvm_analysis_port  #(uvma_{{ name }}_phy_seq_item_c)  {{ rx }}_phy_seq_item_ap; ///< Port outputting {{ rx.upper() }} Phy Sequence Items from #driver.
   uvm_analysis_port  #(uvma_{{ name }}_phy_mon_trn_c )  {{ tx }}_phy_mon_trn_ap; ///< Port outputting {{ tx.upper() }} Phy Monitor Transactions from #monitor.
   uvm_analysis_port  #(uvma_{{ name }}_phy_mon_trn_c )  {{ rx }}_phy_mon_trn_ap; ///< Port outputting {{ rx.upper() }} Phy Monitor Transactions from #monitor.
{% else %}   uvm_analysis_port  #(uvma_{{ name }}_{{ tx }}_seq_item_c)  {{ tx }}_phy_seq_item_ap; ///< Port outputting {{ tx.upper() }} Phy Sequence Items from #driver.
   uvm_analysis_port  #(uvma_{{ name }}_{{ rx }}_seq_item_c)  {{ rx }}_phy_seq_item_ap; ///< Port outputting {{ rx.upper() }} Phy Sequence Items from #driver.
   uvm_analysis_port  #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  {{ tx }}_phy_mon_trn_ap; ///< Port outputting {{ tx.upper() }} Phy Monitor Transactions from #monitor.
   uvm_analysis_port  #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  {{ rx }}_phy_mon_trn_ap; ///< Port outputting {{ rx.upper() }} Phy Monitor Transactions from #monitor.
{% endif %}   /// @}


   `uvm_component_utils_begin(uvma_{{ name }}_agent_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_agent", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Builds all components
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * 1. Links agent's analysis ports to sub-components'
    * 2. Connects coverage models and loggers
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Starts Virtual Sequences on #vsequencer vital both for driving and monitoring.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_and_set_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_and_set_cntxt();

   /**
    * Uses uvm_config_db to retrieve the Virtual Interface (vif) assigned to this agent.
    */
   extern function void retrieve_vif();

   /**
    * Creates sub-components.
    */
   extern function void create_components();

   /**
    * Connects #vsequencer to #monitor and #driver's TLM ports.
    */
   extern function void connect_sequencer;

   /**
    * Connects agent's TLM ports to #driver's and #monitor's.
    */
   extern function void connect_analysis_ports();

   /**
    * Connects #cov_model to #monitor and #driver's analysis ports.
    */
   extern function void connect_cov_model();

   /**
    * Connects #logger to #monitor and #driver's analysis ports.
    */
   extern function void connect_logger();

   /**
    * Starts Monitoring Virtual Sequence.
    */
   extern task start_mon_vseq();

   /**
    * Starts IDLE Generating Virtual Sequence.
    */
   extern task start_idle_vseq();

   /**
    * Starts {{ tx.upper() }} Driver Virtual Sequence.
    */
   extern task start_drv_vseq_{{ mode_1 }}();

   /**
    * Starts {{ rx.upper() }} Driver Virtual Sequence.
    */
   extern task start_drv_vseq_{{ mode_2 }}();

endclass : uvma_{{ name }}_agent_c


function uvma_{{ name }}_agent_c::new(string name="uvma_{{ name }}_agent", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_agent_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_and_set_cfg  ();
   get_and_set_cntxt();
   retrieve_vif     ();
   create_components();

endfunction : build_phase


function void uvma_{{ name }}_agent_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   connect_sequencer();
   connect_analysis_ports();
   if (cfg.cov_model_enabled) begin
      connect_cov_model();
   end
   if (cfg.trn_log_enabled) begin
      connect_logger();
   end

endfunction: connect_phase


task uvma_{{ name }}_agent_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   if (cfg.enabled) begin
      start_mon_vseq();
      if (cfg.is_active) begin
         start_idle_vseq();
         case (cfg.drv_mode)
            UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: start_drv_vseq_{{ mode_1 }}();
            UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: start_drv_vseq_{{ mode_2 }}();
            default: begin
               `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Invalid cfg.drv_mode: %s", cfg.drv_mode.name()))
            end
         endcase
      end
   end

endtask : run_phase


function void uvma_{{ name }}_agent_c::get_and_set_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", "Configuration handle is null")
   end
   else begin
      `uvm_info("{{ name.upper() }}_AGENT", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
      uvm_config_db#(uvma_{{ name }}_cfg_c)::set(this, "*", "cfg", cfg);
   end

endfunction : get_and_set_cfg


function void uvma_{{ name }}_agent_c::get_and_set_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_info("{{ name.upper() }}_AGENT", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvma_{{ name }}_cntxt_c::type_id::create("cntxt");
   end
   uvm_config_db#(uvma_{{ name }}_cntxt_c)::set(this, "*", "cntxt", cntxt);

endfunction : get_and_set_cntxt


function void uvma_{{ name }}_agent_c::retrieve_vif();

   if (!uvm_config_db#(virtual uvma_{{ name }}_if)::get(this, "", "vif", cntxt.vif)) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Could not find vif handle of type %s in uvm_config_db", $typename(cntxt.vif)))
   end
   else begin
      `uvm_info("{{ name.upper() }}_AGENT", $sformatf("Found vif handle of type %s in uvm_config_db", $typename(cntxt.vif)), UVM_DEBUG)
   end

endfunction : retrieve_vif


function void uvma_{{ name }}_agent_c::create_components();

   vsequencer = uvma_{{ name }}_vsqr_c     ::type_id::create("vsequencer", this);
   driver     = uvma_{{ name }}_drv_c      ::type_id::create("driver"    , this);
   monitor    = uvma_{{ name }}_mon_c      ::type_id::create("monitor"   , this);
   cov_model  = uvma_{{ name }}_cov_model_c::type_id::create("cov_model" , this);
   logger     = uvma_{{ name }}_logger_c   ::type_id::create("logger"    , this);

endfunction : create_components


function void uvma_{{ name }}_agent_c::connect_sequencer();

   vsequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
   vsequencer.{{ tx }}_sequencer.set_arbitration(UVM_SEQ_ARB_FIFO);
   vsequencer.{{ rx }}_sequencer.set_arbitration(UVM_SEQ_ARB_FIFO);
   if (!cfg.bypass_mode) begin
      driver .{{ tx }}_driver.seq_item_port.connect(vsequencer.{{ tx }}_sequencer.seq_item_export);
      driver .{{ rx }}_driver.seq_item_port.connect(vsequencer.{{ rx }}_sequencer.seq_item_export);
      monitor.{{ tx }}_ap.connect(vsequencer.{{ tx }}_phy_mon_trn_export);
      monitor.{{ rx }}_ap.connect(vsequencer.{{ rx }}_phy_mon_trn_export);
   end

endfunction : connect_sequencer


function void uvma_{{ name }}_agent_c::connect_analysis_ports();

   upstream_sqr_port = vsequencer.upstream_sqr_port;
   seq_item_ap       = vsequencer.seq_item_ap;
   {{ tx }}_mon_trn_ap      = vsequencer.{{ tx }}_mon_trn_ap;
   {{ rx }}_mon_trn_ap      = vsequencer.{{ rx }}_mon_trn_ap;
   {{ tx }}_phy_seq_item_ap = driver .{{ tx }}_ap;
   {{ rx }}_phy_seq_item_ap = driver .{{ rx }}_ap;
   {{ tx }}_phy_mon_trn_ap  = monitor.{{ tx }}_ap;
   {{ rx }}_phy_mon_trn_ap  = monitor.{{ rx }}_ap;

endfunction : connect_analysis_ports


function void uvma_{{ name }}_agent_c::connect_cov_model();

   seq_item_ap.connect(cov_model.seq_item_export);
   {{ tx }}_mon_trn_ap     .connect(cov_model.{{ tx }}_mon_trn_export     );
   {{ rx }}_mon_trn_ap     .connect(cov_model.{{ rx }}_mon_trn_export     );
   {{ tx }}_phy_seq_item_ap.connect(cov_model.{{ tx }}_phy_seq_item_export);
   {{ rx }}_phy_seq_item_ap.connect(cov_model.{{ rx }}_phy_seq_item_export);
   {{ tx }}_phy_mon_trn_ap .connect(cov_model.{{ tx }}_phy_mon_trn_export );
   {{ rx }}_phy_mon_trn_ap .connect(cov_model.{{ rx }}_phy_mon_trn_export );

endfunction : connect_cov_model


function void uvma_{{ name }}_agent_c::connect_logger();

   seq_item_ap.connect(logger.seq_item_export);
   {{ tx }}_mon_trn_ap     .connect(logger.{{ tx }}_mon_trn_export     );
   {{ rx }}_mon_trn_ap     .connect(logger.{{ rx }}_mon_trn_export     );
   {{ tx }}_phy_seq_item_ap.connect(logger.{{ tx }}_phy_seq_item_export);
   {{ rx }}_phy_seq_item_ap.connect(logger.{{ rx }}_phy_seq_item_export);
   {{ tx }}_phy_mon_trn_ap .connect(logger.{{ tx }}_phy_mon_trn_export );
   {{ rx }}_phy_mon_trn_ap .connect(logger.{{ rx }}_phy_mon_trn_export );

endfunction : connect_logger


task uvma_{{ name }}_agent_c::start_mon_vseq();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.mon_vseq_type, get_full_name(), cfg.mon_vseq_type.get_type_name());
   if (!$cast(cntxt.mon_vseq, temp_obj)) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.mon_vseq' (%s)", $typename(temp_obj), $typename(cntxt.mon_vseq)))
   end
   if (!cntxt.mon_vseq.randomize()) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", "Failed to randomize cntxt.mon_vseq")
   end
   fork
      cntxt.mon_vseq.start(vsequencer);
   join_none

endtask : start_mon_vseq


task uvma_{{ name }}_agent_c::start_idle_vseq();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.idle_vseq_type, get_full_name(), cfg.idle_vseq_type.get_type_name());
   if (!$cast(cntxt.idle_vseq, temp_obj)) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.idle_vseq' (%s)", $typename(temp_obj), $typename(cntxt.idle_vseq)))
   end
   if (!cntxt.idle_vseq.randomize()) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", "Failed to randomize cntxt.idle_vseq")
   end
   fork
      cntxt.idle_vseq.start(vsequencer);
   join_none

endtask : start_idle_vseq


task uvma_{{ name }}_agent_c::start_drv_vseq_{{ mode_1 }}();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.{{ tx }}_drv_vseq_type, get_full_name(), cfg.{{ tx }}_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.{{ tx }}_drv_vseq, temp_obj)) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.{{ tx }}_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.{{ tx }}_drv_vseq)))
   end
   if (!cntxt.{{ tx }}_drv_vseq.randomize()) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", "Failed to randomize cntxt.{{ tx }}_drv_vseq")
   end
   fork
      cntxt.{{ tx }}_drv_vseq.start(vsequencer);
   join_none

endtask : start_drv_vseq_{{ mode_1 }}


task uvma_{{ name }}_agent_c::start_drv_vseq_{{ mode_2 }}();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.{{ rx }}_drv_vseq_type, get_full_name(), cfg.{{ rx }}_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.{{ rx }}_drv_vseq, temp_obj)) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.{{ rx }}_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.{{ rx }}_drv_vseq)))
   end
   if (!cntxt.{{ rx }}_drv_vseq.randomize()) begin
      `uvm_fatal("{{ name.upper() }}_AGENT", "Failed to randomize cntxt.{{ rx }}_drv_vseq")
   end
   fork
      cntxt.{{ rx }}_drv_vseq.start(vsequencer);
   join_none

endtask : start_drv_vseq_{{ mode_2 }}


`endif // __UVMA_{{ name.upper() }}_AGENT_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_AGENT_SV__
`define __UVMA_{{ upper(name) }}_AGENT_SV__


/**
 * Top-level component that encapsulates, builds and connects all others.  Capable of driving/monitoring the {{ full_name }}.
 */
class uvma_{{ name }}_agent_c extends uvml_agent_c;

   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle

   // Components
   uvma_{{ name }}_drv_c        driver    ; ///< TODO Describe uvma_{{ name }}_agent_c::driver
   uvma_{{ name }}_mon_c        monitor   ; ///< TODO Describe uvma_{{ name }}_agent_c::monitor
   uvma_{{ name }}_vsqr_c       vsequencer; ///< TODO Describe uvma_{{ name }}_agent_c::vsequencer
   uvma_{{ name }}_logger_c     logger    ; ///< TODO Describe uvma_{{ name }}_agent_c::logger
   uvma_{{ name }}_cov_model_c  cov_model ; ///< TODO Describe uvma_{{ name }}_agent_c::cov_model

   // TLM
   uvm_seq_item_pull_port #(uvm_sequence_item)  upstream_sqr_port; ///< TODO Describe uvma_{{ name }}_vsqr_c::upstream_sqr_port
   uvm_analysis_port      #(uvma_{{ name }}_seq_item_c   )  seq_item_ap      ; ///< TODO Describe uvma_{{ name }}_agent_c::seq_item_ap
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ tx }}_ap    ; ///< TODO Describe uvma_{{ name }}_agent_c::mon_trn_{{ tx }}_ap
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c    )  mon_trn_{{ rx }}_ap    ; ///< TODO Describe uvma_{{ name }}_agent_c::mon_trn_{{ rx }}_ap
   uvm_analysis_port      #(uvma_{{ name }}_{{ tx }}_seq_item_c)  drv_{{ tx }}_ap        ; ///< TODO Describe uvma_{{ name }}_agent_c::drv_{{ tx }}_a_ap
   uvm_analysis_port      #(uvma_{{ name }}_{{ rx }}_seq_item_c)  drv_{{ rx }}_ap        ; ///< TODO Describe uvma_{{ name }}_agent_c::drv_{{ rx }}_a_ap
   uvm_analysis_port      #(uvma_{{ name }}_{{ tx }}_mon_trn_c )  mon_{{ tx }}_ap        ; ///< TODO Describe uvma_{{ name }}_agent_c::mon_{{ tx }}_a_ap
   uvm_analysis_port      #(uvma_{{ name }}_{{ rx }}_mon_trn_c )  mon_{{ rx }}_ap        ; ///< TODO Describe uvma_{{ name }}_agent_c::mon_{{ rx }}_a_ap


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
    * TODO Describe uvma_{{ name }}_agent_c::run_phase()
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
    * Uses uvm_config_db to retrieve the Virtual Interface (vif) associated with this agent.
    */
   extern function void retrieve_vif();

   /**
    * Creates sub-components.
    */
   extern function void create_components();

   /**
    * TODO Describe uvma_{{ name }}_agent_c::create_analysis_ports()
    */
    extern function void create_analysis_ports();

   /**
    * Connects sequencer to monitor and driver's TLM ports.
    */
   extern function void connect_sequencer;

   /**
    * Connects agent's TLM ports to driver's and monitor's.
    */
   extern function void connect_analysis_ports();

   /**
    * Connects coverage model to monitor and driver's analysis ports.
    */
   extern function void connect_cov_model();

   /**
    * Connects transaction logger to monitor and driver's analysis ports.
    */
   extern function void connect_logger();

   /**
    * TODO Describe uvma_{{ name }}_agent_c::start_mon_vseq()
    */
   extern task start_mon_vseq();

   /**
    * TODO Describe uvma_{{ name }}_agent_c::start_idle_vseq()
    */
   extern task start_idle_vseq();

   /**
    * TODO Describe uvma_{{ name }}_agent_c::start_{{ tx }}_drv_vseq()
    */
   extern task start_{{ tx }}_drv_vseq();

   /**
    * TODO Describe uvma_{{ name }}_agent_c::start_{{ rx }}_drv_vseq()
    */
   extern task start_{{ rx }}_drv_vseq();

endclass : uvma_{{ name }}_agent_c


function uvma_{{ name }}_agent_c::new(string name="uvma_{{ name }}_agent", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_agent_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   get_and_set_cfg      ();
   get_and_set_cntxt    ();
   retrieve_vif         ();
   create_components    ();
   create_analysis_ports();

endfunction : build_phase


function void uvma_{{ name }}_agent_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   connect_sequencer     ();
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
            UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_1) }}: start_{{ tx }}_drv_vseq();
            UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_2) }}: start_{{ rx }}_drv_vseq();

            default: begin
               `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Invalid cfg.drv_mode: %s", cfg.drv_mode.name()))
            end
         endcase
      end
   end

endtask : run_phase


function void uvma_{{ name }}_agent_c::get_and_set_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", "Configuration handle is null")
   end
   else begin
      `uvm_info("{{ upper(name) }}_AGENT", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
      uvm_config_db#(uvma_{{ name }}_cfg_c)::set(this, "*", "cfg", cfg);
   end

endfunction : get_and_set_cfg


function void uvma_{{ name }}_agent_c::get_and_set_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_info("{{ upper(name) }}_AGENT", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvma_{{ name }}_cntxt_c::type_id::create("cntxt");
   end
   uvm_config_db#(uvma_{{ name }}_cntxt_c)::set(this, "*", "cntxt", cntxt);

endfunction : get_and_set_cntxt


function void uvma_{{ name }}_agent_c::retrieve_vif();

   if (!uvm_config_db#(virtual uvma_{{ name }}_if)::get(this, "", "vif", cntxt.vif)) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Could not find vif handle of type %s in uvm_config_db", $typename(cntxt.vif)))
   end
   else begin
      `uvm_info("{{ upper(name) }}_AGENT", $sformatf("Found vif handle of type %s in uvm_config_db", $typename(cntxt.vif)), UVM_DEBUG)
   end

endfunction : retrieve_vif


function void uvma_{{ name }}_agent_c::create_components();

   monitor    = uvma_{{ name }}_mon_c      ::type_id::create("monitor"   , this);
   vsequencer = uvma_{{ name }}_vsqr_c     ::type_id::create("vsequencer", this);
   driver     = uvma_{{ name }}_drv_c      ::type_id::create("driver"    , this);
   cov_model  = uvma_{{ name }}_cov_model_c::type_id::create("cov_model" , this);
   logger     = uvma_{{ name }}_logger_c   ::type_id::create("logger"    , this);

endfunction : create_components


function void uvma_{{ name }}_agent_c::create_analysis_ports();

   upstream_sqr_port = new("upstream_sqr_port", this);
   seq_item_ap       = new("seq_item_ap"      , this);
   mon_trn_{{ tx }}_ap = new("mon_trn_{{ tx }}_ap", this);
   mon_trn_{{ rx }}_ap = new("mon_trn_{{ rx }}_ap", this);
   mon_{{ tx }}_ap     = new("mon_{{ tx }}_ap"    , this);
   mon_{{ rx }}_ap     = new("mon_{{ rx }}_ap"    , this);
   drv_{{ tx }}_ap     = new("drv_{{ tx }}_ap"    , this);
   drv_{{ rx }}_ap     = new("drv_{{ rx }}_ap"    , this);

endfunction : create_analysis_ports


function void uvma_{{ name }}_agent_c::connect_sequencer();

   vsequencer.frame_sequencer.set_arbitration(cfg.sqr_arb_mode);
   vsequencer.{{ tx }}_serial_sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
   vsequencer.{{ rx }}_serial_sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);

   if (!cfg.bypass_mode) begin
      driver .{{ tx }}_driver.seq_item_port.connect(vsequencer.{{ tx }}_serial_sequencer.seq_item_export);
      driver .{{ rx }}_driver.seq_item_port.connect(vsequencer.{{ rx }}_serial_sequencer.seq_item_export);
      monitor.{{ tx }}_ap.connect(vsequencer.{{ tx }}_mon_trn_export);
      monitor.{{ rx }}_ap.connect(vsequencer.{{ rx }}_mon_trn_export);
   end

endfunction : connect_sequencer


function void uvma_{{ name }}_agent_c::connect_analysis_ports();

   upstream_sqr_port = vsequencer.upstream_sqr_port;
   mon_trn_{{ tx }}_ap = vsequencer.mon_trn_{{ tx }}_ap;
   mon_trn_{{ rx }}_ap = vsequencer.mon_trn_{{ rx }}_ap;
   seq_item_ap = vsequencer.seq_item_ap;
   drv_{{ tx }}_ap = driver.{{ tx }}_driver.ap;
   drv_{{ rx }}_ap = driver.{{ rx }}_driver.ap;
   mon_{{ tx }}_ap = monitor.{{ tx }}_ap      ;
   mon_{{ rx }}_ap = monitor.{{ rx }}_ap      ;

endfunction : connect_analysis_ports


function void uvma_{{ name }}_agent_c::connect_cov_model();

   seq_item_ap.connect(cov_model.seq_item_fifo.analysis_export);
   mon_trn_{{ tx }}_ap.connect(cov_model.mon_trn_{{ tx }}_fifo .analysis_export);
   mon_trn_{{ rx }}_ap.connect(cov_model.mon_trn_{{ rx }}_fifo .analysis_export);
   drv_{{ tx }}_ap    .connect(cov_model.{{ tx }}_seq_item_fifo.analysis_export);
   drv_{{ rx }}_ap    .connect(cov_model.{{ rx }}_seq_item_fifo.analysis_export);
   mon_{{ tx }}_ap    .connect(cov_model.{{ tx }}_mon_trn_fifo .analysis_export);
   mon_{{ rx }}_ap    .connect(cov_model.{{ rx }}_mon_trn_fifo .analysis_export);

endfunction : connect_cov_model


function void uvma_{{ name }}_agent_c::connect_logger();

   seq_item_ap.connect(logger.seq_item_export);
   mon_trn_{{ tx }}_ap.connect(logger.mon_trn_{{ tx }}_export );
   mon_trn_{{ rx }}_ap.connect(logger.mon_trn_{{ rx }}_export );
   drv_{{ tx }}_ap    .connect(logger.{{ tx }}_seq_item_export);
   drv_{{ rx }}_ap    .connect(logger.{{ rx }}_seq_item_export);
   mon_{{ tx }}_ap    .connect(logger.{{ tx }}_mon_trn_export );
   mon_{{ rx }}_ap    .connect(logger.{{ rx }}_mon_trn_export );

endfunction : connect_logger


task uvma_{{ name }}_agent_c::start_mon_vseq();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.mon_vseq_type, get_full_name(), cfg.mon_vseq_type.get_type_name());
   if (!$cast(cntxt.mon_vseq, temp_obj)) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.mon_vseq' (%s)", $typename(temp_obj), $typename(cntxt.mon_vseq)))
   end

   if (!cntxt.mon_vseq.randomize()) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", "Failed to randomize cntxt.mon_vseq")
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
      `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.idle_vseq' (%s)", $typename(temp_obj), $typename(cntxt.idle_vseq)))
   end

   if (!cntxt.idle_vseq.randomize()) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", "Failed to randomize cntxt.idle_vseq")
   end

   fork
      cntxt.idle_vseq.start(vsequencer);
   join_none

endtask : start_idle_vseq


task uvma_{{ name }}_agent_c::start_{{ tx }}_drv_vseq();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.{{ tx }}_drv_vseq_type, get_full_name(), cfg.{{ tx }}_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.{{ tx }}_drv_vseq, temp_obj)) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.{{ tx }}_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.{{ tx }}_drv_vseq)))
   end

   if (!cntxt.{{ tx }}_drv_vseq.randomize()) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", "Failed to randomize cntxt.{{ tx }}_drv_vseq")
   end

   fork
      cntxt.{{ tx }}_drv_vseq.start(vsequencer);
   join_none

endtask : start_{{ tx }}_drv_vseq


task uvma_{{ name }}_agent_c::start_{{ rx }}_drv_vseq();

   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;

   temp_obj = f.create_object_by_type(cfg.{{ rx }}_drv_vseq_type, get_full_name(), cfg.{{ rx }}_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.{{ rx }}_drv_vseq, temp_obj)) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.{{ rx }}_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.{{ rx }}_drv_vseq)))
   end

   if (!cntxt.{{ rx }}_drv_vseq.randomize()) begin
      `uvm_fatal("{{ upper(name) }}_AGENT", "Failed to randomize cntxt.{{ rx }}_drv_vseq")
   end

   fork
      cntxt.{{ rx }}_drv_vseq.start(vsequencer);
   join_none

endtask : start_{{ rx }}_drv_vseq


`endif // __UVMA_{{ upper(name) }}_AGENT_SV__

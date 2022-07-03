// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_OBI_ST_ENV_SV__
`define __UVME_OBI_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other Open Bus Interface environment components.
 */
class uvme_obi_st_env_c extends uvml_env_c;

   // Objects
   uvme_obi_st_cfg_c    cfg  ; ///<
   uvme_obi_st_cntxt_c  cntxt; ///<

   // Agents
   uvma_obi_agent_c  mstr_agent; ///<
   uvma_obi_agent_c  slv_agent ; ///<

   // Components
   uvme_obi_st_prd_c                   predictor ; ///<
   uvme_obi_st_sb_simplex_c            sb_e2e    ; ///<
   uvme_obi_st_sb_simplex_c            sb_mstr   ; ///<
   uvme_obi_st_sb_simplex_c            sb_slv    ; ///<
   uvme_obi_st_vsqr_c                  vsequencer; ///<
   uvml_delay_c #(uvma_obi_mon_trn_c)  delay_e2e ; ///<
   uvml_delay_c #(uvma_obi_mon_trn_c)  delay_mstr; ///<
   uvml_delay_c #(uvma_obi_mon_trn_c)  delay_slv ; ///<


   `uvm_component_utils_begin(uvme_obi_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_obi_st_env", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Retrieves cntxt.clk_vif from UVM configuration database via retrieve_clk_vif()
    * 3. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 4. Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 3. Assembles virtual sequencer handles via assemble_vsequencer()
    * 4. Connects agents to coverage model via connect_coverage_model()
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * TODO Describe uvme_obi_st_env_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern function void assign_cfg();

   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern function void assign_cntxt();

   /**
    * Creates agent components.
    */
   extern function void create_agents();

   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern function void create_env_components();

   /**
    * Creates environment's virtual sequencer.
    */
   extern function void create_vsequencer();

   /**
    * Connects agents to predictor.
    */
   extern function void connect_predictor();

   /**
    * Connects scoreboards components to agents/predictor.
    */
   extern function void connect_scoreboard();

   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   extern function void assemble_vsequencer();

endclass : uvme_obi_st_env_c


function uvme_obi_st_env_c::new(string name="uvme_obi_st_env", uvm_component parent=null);

   super.new(name, parent);

   set_type_override_by_type(
      uvma_obi_cov_model_c   ::get_type(),
      uvme_obi_st_cov_model_c::get_type(),
   );

endfunction : new


function void uvme_obi_st_env_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_obi_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end

   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_obi_st_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (cntxt == null) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvme_obi_st_cntxt_c::type_id::create("cntxt");
      end

      assign_cfg           ();
      assign_cntxt         ();
      create_agents        ();
      create_env_components();

      if (cfg.is_active) begin
         create_vsequencer();
      end
   end

endfunction : build_phase


function void uvme_obi_st_env_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   if (cfg.enabled) begin
      if (cfg.scoreboarding_enabled) begin
         connect_predictor ();
         connect_scoreboard();
      end

      if (cfg.is_active) begin
         assemble_vsequencer();
      end
   end

endfunction: connect_phase


task uvme_obi_st_env_c::run_phase(uvm_phase phase);

   uvma_obi_slv_handler_mem_vseq_c  slv_mem_vseq;

   super.run_phase(phase);
   slv_mem_vseq = uvma_obi_slv_handler_mem_vseq_c::type_id::create("slv_mem_vseq");
   slv_mem_vseq.start(vsequencer.slv_vsequencer);

endtask : run_phase


function void uvme_obi_st_env_c::assign_cfg();

   uvm_config_db#(uvme_obi_st_cfg_c    )::set(this, "*"         , "cfg", cfg            );
   uvm_config_db#(uvma_obi_cfg_c       )::set(this, "mstr_agent", "cfg", cfg.mstr_cfg   );
   uvm_config_db#(uvma_obi_cfg_c       )::set(this, "slv_agent" , "cfg", cfg.slv_cfg    );
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_e2e"    , "cfg", cfg.sb_e2e_cfg );
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_mstr"   , "cfg", cfg.sb_mstr_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_slv"    , "cfg", cfg.sb_slv_cfg );

endfunction: assign_cfg


function void uvme_obi_st_env_c::assign_cntxt();

   uvm_config_db#(uvme_obi_st_cntxt_c    )::set(this, "*"         , "cntxt", cntxt              );
   uvm_config_db#(uvma_obi_cntxt_c       )::set(this, "mstr_agent", "cntxt", cntxt.mstr_cntxt   );
   uvm_config_db#(uvma_obi_cntxt_c       )::set(this, "slv_agent" , "cntxt", cntxt.slv_cntxt    );
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_e2e"    , "cntxt", cntxt.sb_e2e_cntxt );
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_mstr"   , "cntxt", cntxt.sb_mstr_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_slv"    , "cntxt", cntxt.sb_slv_cntxt );

endfunction: assign_cntxt


function void uvme_obi_st_env_c::create_agents();

   mstr_agent = uvma_obi_agent_c::type_id::create("mstr_agent", this);
   slv_agent  = uvma_obi_agent_c::type_id::create("slv_agent" , this);

endfunction: create_agents


function void uvme_obi_st_env_c::create_env_components();

   if (cfg.scoreboarding_enabled) begin
      predictor  = uvme_obi_st_prd_c                 ::type_id::create("predictor" , this);
      sb_e2e     = uvme_obi_st_sb_simplex_c          ::type_id::create("sb_e2e"    , this);
      sb_mstr    = uvme_obi_st_sb_simplex_c          ::type_id::create("sb_mstr"   , this);
      sb_slv     = uvme_obi_st_sb_simplex_c          ::type_id::create("sb_slv"    , this);
      delay_e2e  = uvml_delay_c #(uvma_obi_mon_trn_c)::type_id::create("delay_e2e" , this);
      delay_mstr = uvml_delay_c #(uvma_obi_mon_trn_c)::type_id::create("delay_mstr", this);
      delay_slv  = uvml_delay_c #(uvma_obi_mon_trn_c)::type_id::create("delay_slv" , this);
   end

endfunction: create_env_components


function void uvme_obi_st_env_c::create_vsequencer();

   vsequencer = uvme_obi_st_vsqr_c::type_id::create("vsequencer", this);

endfunction: create_vsequencer


function void uvme_obi_st_env_c::connect_predictor();

   // Connect agent -> predictor
   if (cfg.sb_e2e_cfg.enabled) begin
      mstr_agent.mon_trn_ap.connect(predictor.e2e_in_export);
   end
   if (cfg.sb_mstr_cfg.enabled) begin
      mstr_agent.seq_item_ap.connect(predictor.mstr_in_export);
   end
   if (cfg.sb_slv_cfg.enabled) begin
      slv_agent.drv_slv_r_ap.connect(predictor.slv_in_export);
   end

endfunction: connect_predictor


function void uvme_obi_st_env_c::connect_scoreboard();

   if (cfg.sb_e2e_cfg.enabled) begin
      // Connect agent -> delay
      slv_agent.mon_trn_ap.connect(delay_e2e.in_export);
      // Connect delay -> scoreboard
      delay_e2e.out_ap.connect(sb_e2e.act_export);
      // Connect predictor -> scoreboard
      predictor.e2e_out_ap.connect(sb_e2e.exp_export);
      // Configure delay
      delay_e2e.set_duration(100);
   end

   if (cfg.sb_mstr_cfg.enabled) begin
      // Connect agent -> delay
      mstr_agent.mon_trn_ap.connect(delay_mstr.in_export);
      // Connect delay -> scoreboard
      delay_mstr.out_ap.connect(sb_mstr.act_export);
      // Connect predictor -> scoreboard
      predictor.mstr_out_ap.connect(sb_mstr.exp_export);
      // Configure delay
      delay_mstr.set_duration(100);
   end

   if (cfg.sb_slv_cfg.enabled) begin
      // Connect agent -> delay
      slv_agent.mon_trn_ap.connect(delay_slv.in_export);
      // Connect delay -> scoreboard
      delay_slv.out_ap.connect(sb_slv.act_export);
      // Connect predictor -> scoreboard
      predictor.slv_out_ap.connect(sb_slv.exp_export);
      // Configure delay
      delay_slv.set_duration(100);
   end

endfunction: connect_scoreboard


function void uvme_obi_st_env_c::assemble_vsequencer();

   vsequencer.mstr_vsequencer = mstr_agent.vsequencer;
   vsequencer.slv_vsequencer  = slv_agent .vsequencer;

endfunction: assemble_vsequencer


`endif // __UVME_OBI_ST_ENV_SV__

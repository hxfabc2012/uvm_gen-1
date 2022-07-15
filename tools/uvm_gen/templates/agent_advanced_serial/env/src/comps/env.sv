// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_ENV_SV__
`define __UVME_{{ upper(name) }}_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other {{ full_name }} environment components.
 */
class uvme_{{ name }}_st_env_c extends uvml_env_c;

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///<
   uvme_{{ name }}_st_cntxt_c  cntxt; ///<
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_{{ name }}_agent_c  {{ mode_1 }}_agent; ///<
   uvma_{{ name }}_agent_c  {{ mode_2 }}_agent; ///<
   uvma_{{ name }}_agent_c  passive_agent; ///<
   /// @}

   /// @defgroup Components
   /// @{
   uvme_{{ name }}_st_prd_c   predictor; ///<
   uvme_{{ name }}_st_sb_c    sb; ///<
   uvme_{{ name }}_st_vsqr_c  vsequencer; ///<
   /// @}


   `uvm_component_utils_begin(uvme_{{ name }}_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_env", uvm_component parent=null);

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

endclass : uvme_{{ name }}_st_env_c


function uvme_{{ name }}_st_env_c::new(string name="uvme_{{ name }}_st_env", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_{{ name }}_st_env_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg();
   if (cfg.enabled) begin
      get_cntxt            ();
      assign_cfg           ();
      assign_cntxt         ();
      create_agents        ();
      create_env_components();
      create_vsequencer    ();
   end

endfunction : build_phase


function void uvme_{{ name }}_st_env_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);
   if (cfg.enabled) begin
      assemble_vsequencer();
      if (cfg.scoreboarding_enabled) begin
         connect_predictor ();
         connect_scoreboard();
      end
   end

endfunction: connect_phase


function void uvme_{{ name }}_st_env_c::get_cfg();

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_ST_ENV", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvme_{{ name }}_st_env_c::get_cntxt();

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_ST_ENV", "Context handle is null")
   end

endfunction : get_cntxt


function void uvme_{{ name }}_st_env_c::assign_cfg();

   uvm_config_db#(uvme_{{ name }}_st_cfg_c )::set(this, "*", "cfg", cfg);
   uvm_config_db#(uvma_{{ name }}_cfg_c    )::set(this, "{{ mode_1 }}_agent", "cfg", cfg.{{ mode_1 }}_cfg);
   uvm_config_db#(uvma_{{ name }}_cfg_c    )::set(this, "{{ mode_2 }}_agent", "cfg", cfg.{{ mode_2 }}_cfg);
   uvm_config_db#(uvma_{{ name }}_cfg_c    )::set(this, "passive_agent", "cfg", cfg.passive_cfg);

endfunction: assign_cfg


function void uvme_{{ name }}_st_env_c::assign_cntxt();

   uvm_config_db#(uvme_{{ name }}_st_cntxt_c )::set(this, "*" "cntxt", cntxt);
   uvm_config_db#(uvma_{{ name }}_cntxt_c    )::set(this, "{{ mode_1 }}_agent", "cntxt", cntxt.{{ mode_1 }}_cntxt);
   uvm_config_db#(uvma_{{ name }}_cntxt_c    )::set(this, "{{ mode_2 }}_agent", "cntxt", cntxt.{{ mode_2 }}_cntxt);
   uvm_config_db#(uvma_{{ name }}_cntxt_c    )::set(this, "passive_agent", "cntxt", cntxt.passive_cntxt);

endfunction: assign_cntxt


function void uvme_{{ name }}_st_env_c::create_agents();

   set_type_override_by_type(uvma_{{ name }}_cov_model_c::get_type(), uvme_{{ name }}_st_cov_model_c::get_type());
   {{ mode_1 }}_agent = uvma_{{ name }}_agent_c::type_id::create("{{ mode_1 }}_agent", this);
   {{ mode_2 }}_agent = uvma_{{ name }}_agent_c::type_id::create("{{ mode_2 }}_agent", this);
   passive_agent = uvma_{{ name }}_agent_c::type_id::create("passive_agent", this);

endfunction: create_agents


function void uvme_{{ name }}_st_env_c::create_env_components();

   if (cfg.scoreboarding_enabled) begin
      predictor = uvme_{{ name }}_st_prd_c::type_id::create("predictor", this);
      sb        = uvme_{{ name }}_st_sb_c ::type_id::create("sb"       , this);
   end

endfunction: create_env_components


function void uvme_{{ name }}_st_env_c::create_vsequencer();

   vsequencer = uvme_{{ name }}_st_vsqr_c::type_id::create("vsequencer", this);

endfunction: create_vsequencer


function void uvme_{{ name }}_st_env_c::connect_predictor();

   // Connect agent -> predictor
   {{ mode_1 }}_agent.{{ tx }}_mon_trn_ap.connect(predictor.{{ tx }}_in_export);
   {{ mode_2 }}_agent.{{ rx }}_mon_trn_ap.connect(predictor.{{ rx }}_in_export);
   {{ mode_1 }}_agent.seq_item_ap.connect(predictor.{{ mode_1 }}_in_export);
   {{ mode_2 }}_agent.seq_item_ap.connect(predictor.{{ mode_2 }}_in_export);

endfunction: connect_predictor


function void uvme_{{ name }}_st_env_c::connect_scoreboard();

   // Connect agent -> scoreboard
   {{ mode_2 }}_agent.{{ tx }}_mon_trn_ap.connect(sb.{{ tx }}_act_export);
   {{ mode_1 }}_agent.{{ rx }}_mon_trn_ap.connect(sb.{{ rx }}_act_export);
   passive_agent.{{ tx }}_mon_trn_ap.connect(sb.{{ mode_1 }}_act_export);
   passive_agent.{{ rx }}_mon_trn_ap.connect(sb.{{ mode_2 }}_act_export);
   // Connect predictor -> scoreboard
   predictor.{{ tx }}_out_ap.connect(sb.{{ tx }}_exp_export);
   predictor.{{ rx }}_out_ap.connect(sb.{{ rx }}_exp_export);
   predictor.{{ mode_1 }}_out_ap.connect(sb.{{ mode_1 }}_exp_export);
   predictor.{{ mode_2 }}_out_ap.connect(sb.{{ mode_2 }}_exp_export);

endfunction: connect_scoreboard


function void uvme_{{ name }}_st_env_c::assemble_vsequencer();

   vsequencer.{{ mode_1 }}_vsequencer = {{ mode_1 }}_agent.vsequencer;
   vsequencer.{{ mode_2 }}_vsequencer = {{ mode_2 }}_agent.vsequencer;
   vsequencer.passive_vsequencer = passive_agent.vsequencer;

endfunction: assemble_vsequencer


`endif // __UVME_{{ upper(name) }}_ST_ENV_SV__

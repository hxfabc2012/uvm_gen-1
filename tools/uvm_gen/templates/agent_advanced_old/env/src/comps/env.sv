// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name_uppercase }}_ST_ENV_SV__
`define __UVME_{{ name_uppercase }}_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other {{ name_proper }} UVM Agent Self-Test Environment
 * (uvme_{{ name }}_st_env_c) components.
 */
class uvme_{{ name }}_st_env_c extends uvml_env_c;

   /// @defgroup Objects
   /// @{
   uvme_{{ name }}_st_cfg_c    cfg  ; ///< Configuration handle.  Must be provided by component instantiating this environment.
   uvme_{{ name }}_st_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this environment.
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_{{ name }}_agent_c  {{ mode_1 }}_agent; ///< Agent instance in mode {{ mode_1 }}.
   uvma_{{ name }}_agent_c  {{ mode_2 }}_agent; ///< Agent instance in mode {{ mode_2 }}.
   /// @}

   /// @defgroup Components
   /// @{
   uvme_{{ name }}_st_vsqr_c        vsequencer; ///< Virtual sequencer on which virtual sequences are run.
   uvme_{{ name }}_st_prd_c         predictor ; ///< Feeds #sb's expected port with monitor transactions from #acive_agent.
{% if full_duplex %}   uvme_{{ name }}_st_sb_duplex_c   sb        ; ///< Ensures that monitored transactions from #{{ mode_1 }}_agent and #{{ mode_2 }}_agent match.
{% else %}   uvme_{{ name }}_st_sb_simplex_c  sb        ; ///< Ensures that monitored transactions from #{{ mode_1 }}_agent and #{{ mode_2 }}_agent match.{% endif %}
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
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Assigns #cfg and #cntxt handles via assign_cfg() & assign_cntxt()
    * 3. Creates all components via create_<x>()
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

   set_type_override_by_type(
      uvma_{{ name }}_cov_model_c   ::get_type(),
      uvme_{{ name }}_st_cov_model_c::get_type(),
   );

endfunction : new


function void uvme_{{ name }}_st_env_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_{{ name }}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("{{ name_uppercase }}_ST_ENV", "Configuration handle is null")
   end
   else begin
      `uvm_info("{{ name_uppercase }}_ST_ENV", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end

   void'(uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_info("{{ name_uppercase }}_ST_ENV", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvme_{{ name }}_st_cntxt_c::type_id::create("cntxt");
   end

   assign_cfg           ();
   assign_cntxt         ();
   create_agents        ();
   create_env_components();
   create_vsequencer    ();

endfunction : build_phase


function void uvme_{{ name }}_st_env_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   assemble_vsequencer();
   connect_predictor  ();
   if (cfg.scoreboarding_enabled) begin
      connect_scoreboard();
   end

endfunction: connect_phase


function void uvme_{{ name }}_st_env_c::assign_cfg();

   uvm_config_db#(uvme_{{ name }}_st_cfg_c)::set(this, "*", "cfg", cfg);
   uvm_config_db#(uvma_{{ name }}_cfg_c   )::set(this, "{{ mode_1 }}_agent", "cfg", cfg.{{ mode_1 }}_cfg );
   uvm_config_db#(uvma_{{ name }}_cfg_c   )::set(this, "{{ mode_2 }}_agent", "cfg", cfg.{{ mode_2 }}_cfg);
{% if full_duplex %}   uvm_config_db#(uvml_sb_duplex_cfg_c)::set(this, "sb", "cfg", cfg.sb_cfg);
{% else %}   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb", "cfg", cfg.sb_cfg);{% endif %}

endfunction: assign_cfg


function void uvme_{{ name }}_st_env_c::assign_cntxt();

   uvm_config_db#(uvme_{{ name }}_st_cntxt_c)::set(this, "*", "cntxt", cntxt);
   uvm_config_db#(uvma_{{ name }}_cntxt_c   )::set(this, "{{ mode_1 }}_agent", "cntxt", cntxt.{{ mode_1 }}_cntxt);
   uvm_config_db#(uvma_{{ name }}_cntxt_c   )::set(this, "{{ mode_2 }}_agent", "cntxt", cntxt.{{ mode_2 }}_cntxt);
{% if full_duplex %}   uvm_config_db#(uvml_sb_duplex_cntxt_c)::set(this, "sb", "cntxt", cntxt.sb_cntxt);
{% else %}   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb", "cntxt", cfg.sb_cntxt);{% endif %}

endfunction: assign_cntxt


function void uvme_{{ name }}_st_env_c::create_agents();

   {{ mode_1 }}_agent = uvma_{{ name }}_agent_c::type_id::create("{{ mode_1 }}_agent", this);
   {{ mode_2 }}_agent = uvma_{{ name }}_agent_c::type_id::create("{{ mode_2 }}_agent", this);

endfunction: create_agents


function void uvme_{{ name }}_st_env_c::create_env_components();

   predictor = uvme_{{ name }}_st_prd_c::type_id::create("predictor", this);
{% if full_duplex %}   sb        = uvme_{{ name }}_st_sb_duplex_c::type_id::create("sb", this);
 %{ else %}   sb        = uvme_{{ name }}_st_sb_simplex_c::type_id::create("sb", this);{% endif %}

endfunction: create_env_components


function void uvme_{{ name }}_st_env_c::create_vsequencer();

   vsequencer = uvme_{{ name }}_st_vsqr_c::type_id::create("vsequencer", this);

endfunction: create_vsequencer


function void uvme_{{ name }}_st_env_c::connect_predictor();
{% if full_duplex %}
   // Connect agents -> predictor
   {{ mode_1 }}_agent.mon_ap.connect(predictor.{{ dir_1 }}_in_export);
   {{ mode_2 }}_agent.mon_ap.connect(predictor.{{ dir_2 }}_in_export);
{% else %}
   // Connect agent -> predictor
   {{ mode_1 }}_agent.mon_ap.connect(predictor.in_export);
{% endif %}
endfunction: connect_predictor


function void uvme_{{ name }}_st_env_c::connect_scoreboard();
{% if full_duplex %}
   // Connect agents -> scoreboard
   {{ mode_1 }}_agent.mon_ap.connect(sb.ingress_act_export);
   {{ mode_2 }}_agent.mon_ap.connect(sb.egress_act_export);

   // Connect predictor -> scoreboard
   predictor.{{ dir_1 }}_out_ap.connect(sb.ingress_act_export);
   predictor.{{ dir_2 }}_out_ap.connect(sb.egress_act_export);
{% else %}
   // Connect agent -> scoreboard
   {{ mode_2 }}_agent.mon_ap.connect(sb.act_export);

   // Connect predictor -> scoreboard
   predictor.out_ap.connect(sb.exp_export);
{% endif %}
endfunction: connect_scoreboard


function void uvme_{{ name }}_st_env_c::assemble_vsequencer();
{% if symmetric %}
   vsequencer.egress_sequencer  = egress_agent .vsequencer;
   vsequencer.ingress_sequencer = ingress_agent.vsequencer;
{% else %}
   vsequencer.{{ mode_1 }}_sequencer = {{ mode_1 }}_agent.vsequencer;
   vsequencer.{{ mode_2 }}_sequencer = {{ mode_2 }}_agent.vsequencer;
{% endif %}
endfunction: assemble_vsequencer


`endif // __UVME_{{ name_uppercase }}_ST_ENV_SV__

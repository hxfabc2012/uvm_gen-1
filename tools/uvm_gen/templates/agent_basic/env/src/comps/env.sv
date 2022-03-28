// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_ENV_SV__
`define __UVME_${name_uppercase}_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other ${name_normal_case} UVM Agent Self-Test Environment
 * (uvme_${name}_st_env_c) components.
 */
class uvme_${name}_st_env_c extends uvm_env;

   /// @defgroup Objects
   /// @{
   uvme_${name}_st_cfg_c    cfg  ; ///< Configuration handle.  Must be provided by component instantiating this environment.
   uvme_${name}_st_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this environment.
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_${name}_agent_c  active_agent ; ///< Agent instance generating stimulus.
   uvma_${name}_agent_c  passive_agent; ///< Agent instance receiving stimulus.
   /// @}

   /// @defgroup Components
   /// @{
   uvme_${name}_st_vsqr_c        vsequencer; ///< Virtual sequencer on which virtual sequences are run.
   uvme_${name}_st_prd_c         predictor ; ///< Feeds #sb's expected port with monitor transactions from #acive_agent.
   uvme_${name}_st_sb_simplex_c  sb        ; ///< Ensures that monitored transactions from #active_agent and #passive_agent match.
   /// @}


   `uvm_component_utils_begin(uvme_${name}_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_st_env", uvm_component parent=null);

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

endclass : uvme_${name}_st_env_c


function uvme_${name}_st_env_c::new(string name="uvme_${name}_st_env", uvm_component parent=null);

   super.new(name, parent);

   set_type_override_by_type(
      uvma_${name}_cov_model_c   ::get_type(),
      uvme_${name}_st_cov_model_c::get_type(),
   );

endfunction : new


function void uvme_${name}_st_env_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end

   void'(uvm_config_db#(uvme_${name}_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvme_${name}_st_cntxt_c::type_id::create("cntxt");
   end

   assign_cfg           ();
   assign_cntxt         ();
   create_agents        ();
   create_env_components();
   create_vsequencer    ();

endfunction : build_phase


function void uvme_${name}_st_env_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   assemble_vsequencer();
   connect_predictor  ();
   if (cfg.scoreboarding_enabled) begin
      connect_scoreboard();
   end

endfunction: connect_phase


function void uvme_${name}_st_env_c::assign_cfg();

   uvm_config_db#(uvme_${name}_st_cfg_c)::set(this, "*"            , "cfg", cfg            );
   uvm_config_db#(uvma_${name}_cfg_c   )::set(this, "active_agent" , "cfg", cfg.active_cfg );
   uvm_config_db#(uvma_${name}_cfg_c   )::set(this, "passive_agent", "cfg", cfg.passive_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb"           , "cfg", cfg.sb_cfg     );

endfunction: assign_cfg


function void uvme_${name}_st_env_c::assign_cntxt();

   uvm_config_db#(uvme_${name}_st_cntxt_c)::set(this, "*"            , "cntxt", cntxt              );
   uvm_config_db#(uvma_${name}_cntxt_c   )::set(this, "active_agent" , "cntxt", cntxt.active_cntxt );
   uvm_config_db#(uvma_${name}_cntxt_c   )::set(this, "passive_agent", "cntxt", cntxt.passive_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb"           , "cntxt", cntxt.sb_cntxt     );

endfunction: assign_cntxt


function void uvme_${name}_st_env_c::create_agents();

   active_agent  = uvma_${name}_agent_c::type_id::create("active_agent" , this);
   passive_agent = uvma_${name}_agent_c::type_id::create("passive_agent", this);

endfunction: create_agents


function void uvme_${name}_st_env_c::create_env_components();

   predictor = uvme_${name}_st_prd_c       ::type_id::create("predictor", this);
   sb        = uvme_${name}_st_sb_simplex_c::type_id::create("sb"       , this);

endfunction: create_env_components


function void uvme_${name}_st_env_c::create_vsequencer();

   vsequencer = uvme_${name}_st_vsqr_c::type_id::create("vsequencer", this);

endfunction: create_vsequencer


function void uvme_${name}_st_env_c::connect_predictor();

   // Connect agent -> predictor
   active_agent.mon_ap.connect(predictor.in_export);

endfunction: connect_predictor


function void uvme_${name}_st_env_c::connect_scoreboard();

   // Connect agent -> scoreboard
   passive_agent.mon_ap.connect(sb.act_export);

   // Connect predictor -> scoreboard
   predictor.out_ap.connect(sb.exp_export);

endfunction: connect_scoreboard


function void uvme_${name}_st_env_c::assemble_vsequencer();

   vsequencer.active_sequencer  = active_agent.sequencer ;
   vsequencer.passive_sequencer = passive_agent.sequencer;

endfunction: assemble_vsequencer


`endif // __UVME_${name_uppercase}_ST_ENV_SV__

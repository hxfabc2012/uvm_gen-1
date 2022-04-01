// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ENV_SV__
`define __UVME_${name_uppercase}_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other ${name_normal_case} Sub-System environment components.
 */
class uvme_${name}_env_c extends uvml_env_c;

   /// @defgroup Objects
   /// @{
   uvme_${name}_cfg_c    cfg  ; ///< Configuration handle.  Must be provided by component instantiating this environment.
   uvme_${name}_cntxt_c  cntxt; ///< Context handle.  Can be provided by component instantiating this environment.
   /// @}

   /// @defgroup Register Abstraction Layer (RAL)
   /// @{
   uvme_${name}_reg_block_c  reg_block; ///< Top-level register block for {name_normal_case} Sub-System.
   uvma_${ral_agent_type}_reg_adapter_c  reg_adapter; ///< Converts ${ral_agent_type} sequence items to/from register operations.
   /// @}

   /// @defgroup Components
   /// @{
   uvme_${name}_vsqr_c       vsequencer; ///< Virtual sequencer on which virtual sequences are run.
   uvme_${name}_prd_c        predictor ; ///< Feeds #sb's expected port(s) with monitor transactions.
   uvme_${name}_sb_c         sb        ; ///< Ensures that transactions from #predictor and monitors match.
   uvme_${name}_cov_model_c  cov_model ; ///< Functional coverage model.
   /// @}

   /// @defgroup Environment(s)
   /// @{
   // TODO: Add sub-environments
   //       Ex: uvme_sub_env_env_c  sub_env; ///< Describe me!
   /// @}

   /// @defgroup Agents
   /// @{
   uvma_clk_agent_c    ${clk_agent_name}_agent  ; ///<
   uvma_reset_agent_c  ${reset_agent_name}_agent; ///<
   uvma_${ral_agent_type}_agent_c  ${ral_agent_name}_agent; ///<
   /// @}


   `uvm_component_utils_begin(uvme_${name}_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_${name}_env", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 3. Creates all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects ral to predictor & provisioning agent via connect_reg_block()
    * 3. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 4. Assembles virtual sequencer handles via assemble_vsequencer()
    * 5. Connects agents to coverage model via connect_coverage_model()
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
    * Creates sub-environment components.
    */
   extern function void create_sub_envs();

   /**
    * Creates agent components.
    */
   extern function void create_agents();

   /**
    * Creates ral_adapter which translates to/from ral to ${ral_agent_type}_agent.
    */
   extern function void create_reg_adapter();

   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern function void create_env_components();

   /**
    * Creates environment's virtual sequencer.
    */
   extern function void create_vsequencer();

   /**
    * Creates environment's coverage model.
    */
   extern function void create_cov_model();

   /**
    * Connects agents to predictor.
    */
   extern function void connect_predictor();

   /**
    * Connects scoreboards components to agents/predictor.
    */
   extern function void connect_scoreboard();

   /**
    * Connects RAL to provisioning agent (${ral_agent_type}_agent).
    */
   extern function void connect_reg_block();

   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   extern function void connect_coverage_model();

   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   extern function void assemble_vsequencer();

endclass : uvme_${name}_env_c


function uvme_${name}_env_c::new(string name="uvme_${name}_env", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvme_${name}_env_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvme_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end

   void'(uvm_config_db#(uvme_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvme_${name}_cntxt_c::type_id::create("cntxt");
   end

   assign_cfg           ();
   assign_cntxt         ();
   create_sub_envs      ();
   create_agents        ();
   create_reg_adapter   ();
   create_env_components();
   create_vsequencer    ();
   create_cov_model     ();

endfunction : build_phase


function void uvme_${name}_env_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   connect_reg_block();
   assemble_vsequencer();

   if (cfg.scoreboarding_enabled) begin
      connect_predictor ();
      connect_scoreboard();
   end

   if (cfg.cov_model_enabled) begin
      connect_coverage_model();
   end

endfunction: connect_phase


function void uvme_${name}_env_c::assign_cfg();

   uvm_config_db#(uvme_${name}_cfg_c)::set(this, "*", "cfg", cfg);
   uvm_config_db#(uvma_clk_cfg_c)::set(this, "${clk_agent_name}_agent", "cfg", cfg.${clk_agent_name}_cfg);
   uvm_config_db#(uvma_reset_cfg_c)::set(this, "${reset_agent_name}_agent", "cfg", cfg.${reset_agent_name}_cfg);
   uvm_config_db#(uvma_${ral_agent_type}_cfg_c)::set(this, "${ral_agent_name}_agent", "cfg", cfg.${ral_agent_name}_cfg);

   // TODO Assign sub-environment cfg handle
   //      Ex: uvm_config_db#(uvme_sub_env_cfg_c)::set(this, "sub_env", "cfg", cfg.sub_env_cfg);

endfunction: assign_cfg


function void uvme_${name}_env_c::assign_cntxt();

   uvm_config_db#(uvme_${name}_cntxt_c)::set(this, "*", "cntxt", cntxt);
   uvm_config_db#(uvma_clk_cntxt_c)::set(this, "${clk_agent_name}_agent", "cntxt", cntxt.${clk_agent_name}_cntxt);
   uvm_config_db#(uvma_reset_cntxt_c)::set(this, "${reset_agent_name}_agent", "cntxt", cntxt.${reset_agent_name}_cntxt);
   uvm_config_db#(uvma_${ral_agent_type}_cntxt_c)::set(this, "${ral_agent_name}_agent", "cntxt", cntxt.${ral_agent_name}_cntxt);

   // TODO Assign sub-environment cntxt handle
   //      Ex: uvm_config_db#(uvme_sub_env_cntxt_c)::set(this, "sub_env", "cntxt", cntxt.sub_env_cntxt);

endfunction: assign_cntxt


function void uvme_${name}_env_c::create_sub_envs();

   // TODO: Create sub-environments
   //       Ex: sub_env = uvme_sub_env_c::type_id::create("sub_env");

endfunction: create_sub_envs


function void uvme_${name}_env_c::create_agents();

   ${clk_agent_name}_agent = uvma_clk_agent_c::type_id::create("${clk_agent_name}_agent", this);
   ${reset_agent_name}_agent = uvma_reset_agent_c::type_id::create("${reset_agent_name}_agent", this);
   ${ral_agent_name}_agent = uvma_${ral_agent_type}_agent_c::type_id::create("${ral_agent_name}_agent", this);

endfunction: create_agents


function void uvme_${name}_env_c::create_env_components();

   if (cfg.scoreboarding_enabled) begin
      predictor = uvme_${name}_prd_c::type_id::create("predictor", this);
      sb        = uvme_${name}_sb_c ::type_id::create("sb"       , this);
   end

endfunction: create_env_components


function void uvme_${name}_env_c::create_reg_adapter();

   reg_adapter = uvma_${ral_agent_type}_reg_adapter_c::type_id::create("reg_adapter");
   reg_block = cfg.${name}_reg_block;

endfunction: create_reg_adapter


function void uvme_${name}_env_c::create_vsequencer();

   vsequencer = uvme_${name}_vsqr_c::type_id::create("vsequencer", this);

endfunction: create_vsequencer


function void uvme_${name}_env_c::create_cov_model();

   cov_model = uvme_${name}_cov_model_c::type_id::create("cov_model", this);

endfunction: create_cov_model


function void uvme_${name}_env_c::connect_predictor();

   ${clk_agent_name}_agent.mon_ap.connect(predictor.${clk_agent_name}_export);
   ${reset_agent_name}_agent.mon_ap.connect(predictor.${reset_agent_name}_export);
   ${ral_agent_name}_agent.mon_ap.connect(predictor.${ral_agent_name}_export);

endfunction: connect_predictor


function void uvme_${name}_env_c::connect_scoreboard();

   // TODO Connect agents -> scoreboard
   //      Ex: ${ral_agent_type}_agent.mon_ap.connect(sb.${ral_agent_type}_sb.act_export);

   // TODO Connect predictor -> scoreboard
   //      Ex: predictor.${ral_agent_type}_ap.connect(sb.${ral_agent_type}_sb.exp_export);

endfunction: connect_scoreboard


function void uvme_${name}_env_c::connect_reg_block();

   reg_block.cntxt = cntxt;
   reg_block.connect();
   reg_block.default_map.set_sequencer(${ral_agent_name}_agent.sequencer, reg_adapter);
   reg_block.default_map.set_auto_predict(1);

endfunction: connect_reg_block


function void uvme_${name}_env_c::connect_coverage_model();

   // TODO Implement uvme_${name}_env_c::connect_coverage_model()
   //      Ex: ${ral_agent_name}_agent.mon_ap.connect(cov_model.${ral_agent_name}_export);

endfunction: connect_coverage_model


function void uvme_${name}_env_c::assemble_vsequencer();

   vsequencer.${clk_agent_name}_sequencer = ${clk_agent_name}_agent.sequencer;
   vsequencer.${reset_agent_name}_sequencer = ${reset_agent_name}_agent.sequencer;
   vsequencer.${ral_agent_name}_sequencer = ${ral_agent_name}_agent.sequencer;

endfunction: assemble_vsequencer


`endif // __UVME_${name_uppercase}_ENV_SV__

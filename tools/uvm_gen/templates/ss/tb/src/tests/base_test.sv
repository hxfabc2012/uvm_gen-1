// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_BASE_TEST_SV__
`define __UVMT_${name_uppercase}_BASE_TEST_SV__


/**
 * Component from which all other ${name_normal_case} Sub-System tests must extend.
 * Subclasses must provide stimulus via the virtual sequencer by implementing UVM runtime phases.
 */
class uvmt_${name}_base_test_c extends uvml_test_c;

   virtual uvmt_${name}_probe_if  probe_vif; ///< Handle to DUT probe interface

   /// @defgroup Objects
   /// @{
   rand uvmt_${name}_test_cfg_c  test_cfg ; ///< Test configuration handle
   rand uvme_${name}_cfg_c       env_cfg  ; ///< Environment configuration handle
   uvme_${name}_cntxt_c          env_cntxt; ///< Environment context handle
   uvme_${name}_reg_block_c      reg_block; ///< Top-level register block handle
   uvml_logs_rs_text_c           rs       ; ///< Custom UVM report server
   uvml_logs_reg_logger_cbs_c    reg_cbs  ; ///< Logs register operations to disk
   /// @}

   /// @defgroup Components
   /// @{
   uvme_${name}_env_c   env       ; ///< Target environment
   uvme_${name}_vsqr_c  vsequencer; ///< Target environment virtual sequencer handle
   /// @}

   /// @defgroup Default sequences
   /// @{
   rand uvme_${name}_${clk_agent_name}_vseq_c  ${clk_agent_name}_vseq; ///< Starts clock generation during pre_reset_phase()
   rand uvme_${name}_${reset_agent_name}_vseq_c  ${reset_agent_name}_vseq; ///< Asserts reset during reset_phase()
   /// @}


   `uvm_component_utils_begin(uvmt_${name}_base_test_c)
      `uvm_field_object(test_cfg , UVM_DEFAULT)
      `uvm_field_object(env_cfg  , UVM_DEFAULT)
      `uvm_field_object(env_cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Sets safe default options for #env_cfg.
    */
   constraint env_cfg_cons {
      env_cfg.enabled               == 1;
      env_cfg.is_active             == UVM_ACTIVE;
      env_cfg.scoreboarding_enabled == 1;
      env_cfg.trn_log_enabled       == 1;
      env_cfg.cov_model_enabled     == 1;
   }

   // Additional, temporary constraints to get around known design bugs/constraints
   `include "uvmt_${name}_base_test_workarounds.sv"


   /**
    * 1. Replaces default report server with rs.
    * 2. Creates reset_vseq.
    */
   extern function new(string name="uvmt_${name}_base_test", uvm_component parent=null);

   /**
    * 1. Builds test_cfg & env_cfg via create_cfg()
    * 2. Randomizes entire test class via randomize_test()
    * 3. Passes env_cfg to env via uvm_config_db via assign_cfg()
    * 4. Builds env_cntxt via create_cntxt()
    * 5. Passes env_cntxt to env using UVM Configuration Database via assign_cntxt()
    * 6. Builds env via create_env()
    * 7. Builds the rest of the components/objects via create_components()
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * 1. Assigns environment's virtual sequencer handle to vsequencer.
    * 2. Add register callback (reg_cbs) to all registers & fields.
    */
   extern virtual function void connect_phase(uvm_phase phase);

   /**
    * Runs ${clk_agent_name}_vseq.
    */
   extern virtual task pre_reset_phase(uvm_phase phase);

   /**
    * Runs ${reset_agent_name}_vseq.
    */
   extern virtual task reset_phase(uvm_phase phase);

   /**
    * Writes contents of RAL to the DUT.
    */
   extern virtual task configure_phase(uvm_phase phase);

   /**
    * Retrieves probe_vif from UVM configuration database.
    */
   extern function void retrieve_probe_vif();

   /**
    * Creates test_cfg and env_cfg. Assigns reg_block handle to env_cfg's.
    */
   extern function void create_cfg();

   /**
    * 1. Calls test_cfg's process_cli_args()
    * 2. Calls randomize on 'this' and fatals out if it fails.
    */
   extern function void randomize_test();

   /**
    * Configures uvml_default_hrtbt_monitor.
    */
   extern function void cfg_hrtbt_monitor();

   /**
    * Assigns environment configuration (env_cfg) handle to environment (env)
    * using UVM Configuration Database.
    */
   extern function void assign_cfg();

   /**
    * Creates env_cntxt.
    */
   extern function void create_cntxt();

   /**
    * Assigns environment context (env_cntxt) handle to environment (env) using
    * UVM Configuration Database.
    */
   extern function void assign_cntxt();

   /**
    * Creates env.
    */
   extern function void create_env();

   /**
    * Creates additional (non-environment) components (and objects).
    */
   extern function void create_components();

endclass : uvmt_${name}_base_test_c


function uvmt_${name}_base_test_c::new(string name="uvmt_${name}_base_test", uvm_component parent=null);

   super.new(name, parent);

   rs = new("rs");
   uvm_report_server::set_server(rs);
   ${clk_agent_name}_vseq = uvme_${name}_${clk_agent_name}_vseq_c::type_id::create("${clk_agent_name}_vseq");
   ${reset_agent_name}_vseq = uvme_${name}_${reset_agent_name}_vseq_c::type_id::create("${reset_agent_name}_vseq");

endfunction : new


function void uvmt_${name}_base_test_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   retrieve_probe_vif();
   create_cfg        ();
   randomize_test    ();
   cfg_hrtbt_monitor ();
   assign_cfg        ();
   create_cntxt      ();
   assign_cntxt      ();
   create_env        ();
   create_components ();

endfunction : build_phase


function void uvmt_${name}_base_test_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   vsequencer = env.vsequencer;
   reg_block  = env.reg_block;
   uvm_reg_cb::add(null, reg_cbs);

endfunction : connect_phase


task uvmt_${name}_base_test_c::pre_reset_phase(uvm_phase phase);

   super.pre_reset_phase(phase);

   `uvm_info("TEST", $sformatf("Starting ${clk_agent_name} virtual sequence:\n%s", ${clk_agent_name}_vseq.sprint()), UVM_NONE)
   ${clk_agent_name}_vseq.start(vsequencer);
   `uvm_info("TEST", "Finished ${clk_agent_name} virtual sequence", UVM_NONE)

endtask : pre_reset_phase


task uvmt_${name}_base_test_c::reset_phase(uvm_phase phase);

   super.reset_phase(phase);

   `uvm_info("TEST", $sformatf("Starting ${reset_agent_name} virtual sequence:\n%s", ${reset_agent_name}_vseq.sprint()), UVM_NONE)
   ${reset_agent_name}_vseq.start(vsequencer);
   `uvm_info("TEST", "Finished ${reset_agent_name} virtual sequence", UVM_NONE)

endtask : reset_phase


task uvmt_${name}_base_test_c::configure_phase(uvm_phase phase);

   uvm_status_e status;

   super.configure_phase(phase);

   if (test_cfg.auto_ral_update) begin
      `uvm_info("TEST", $sformatf("Starting to update DUT with RAL contents:\n%s", reg_block.sprint()), UVM_NONE)
      reg_block.update(status);
      `uvm_info("TEST", "Finished updating DUT with RAL contents", UVM_NONE)
   end

endtask : configure_phase


function void uvmt_${name}_base_test_c::retrieve_probe_vif();

   if (!uvm_config_db#(virtual uvmt_${name}_probe_if)::get(this, "", "vif", probe_vif)) begin
      `uvm_fatal("TEST", $sformatf("Could not find probe_vif handle of type %s in uvm_config_db", $typename(probe_vif)))
   end
   else begin
      `uvm_info("TEST", $sformatf("Found probe_vif handle of type %s in uvm_config_db", $typename(probe_vif)), UVM_DEBUG)
   end

endfunction : retrieve_probe_vif


function void uvmt_${name}_base_test_c::create_cfg();

   test_cfg = uvmt_${name}_test_cfg_c::type_id::create("test_cfg");
   env_cfg  = uvme_${name}_cfg_c     ::type_id::create("env_cfg" );

endfunction : create_cfg


function void uvmt_${name}_base_test_c::randomize_test();

   test_cfg.process_cli_args();
   `uvm_info("TEST", "Randomizing test ...", UVM_NONE)
   if (!this.randomize()) begin
      `uvm_fatal("TEST", "Failed to randomize test");
   end
   `uvm_info("TEST", $sformatf("Top-level environment configuration:\n%s", env_cfg.sprint()), UVM_NONE)

endfunction : randomize_test


function void uvmt_${name}_base_test_c::cfg_hrtbt_monitor();

   `uvml_hrtbt_set_cfg(startup_timeout , test_cfg.startup_timeout)
   `uvml_hrtbt_set_cfg(heartbeat_period, test_cfg.heartbeat_period)
   `uvml_watchdog_set_cfg(timeout, test_cfg.simulation_timeout)

endfunction : cfg_hrtbt_monitor


function void uvmt_${name}_base_test_c::assign_cfg();

   uvm_config_db#(uvme_${name}_cfg_c)::set(this, "env", "cfg", env_cfg);

endfunction : assign_cfg


function void uvmt_${name}_base_test_c::create_cntxt();

   env_cntxt = uvme_${name}_cntxt_c::type_id::create("env_cntxt");

endfunction : create_cntxt


function void uvmt_${name}_base_test_c::assign_cntxt();

   uvm_config_db#(uvme_${name}_cntxt_c)::set(this, "env", "cntxt", env_cntxt);

endfunction : assign_cntxt


function void uvmt_${name}_base_test_c::create_env();

   env = uvme_${name}_env_c::type_id::create("env", this);

endfunction : create_env


function void uvmt_${name}_base_test_c::create_components();

   reg_cbs = uvml_logs_reg_logger_cbs_c::type_id::create("reg_cbs");

endfunction : create_components


`endif // __UVMT_${name_uppercase}_BASE_TEST_SV__

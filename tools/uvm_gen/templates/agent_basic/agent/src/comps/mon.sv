// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_MON_SV__
`define __UVMA_${name_uppercase}_MON_SV__


/**
 * Component sampling transactions from ${name_normal_case} virtual interface (uvma_${name}_if).
 */
class uvma_${name}_mon_c extends uvm_monitor;

   /// @defgroup Objects
   /// @{
   uvma_${name}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_port#(uvma_${name}_mon_trn_c)  ap; ///< Port producing sampled transactions.
   /// @}

   /// @defgroup Interface handles
   /// @{
   virtual uvma_${name}_if.mon_mp  mp; ///< Handle to monitor modport
   /// @}


   `uvm_component_utils_begin(uvma_${name}_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_mon", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null
    * 2. Builds #ap
    * 3. Obtains #mp handle
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Oversees monitoring, depending on the reset state, by calling mon_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Updates the context's reset state.
    */
   extern virtual task observe_reset();

   /**
    * Synchronous reset thread.
    */
   extern virtual task observe_reset_sync();

   /**
    * Asynchronous reset thread.
    */
   extern virtual task observe_reset_async();

   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_pre_reset();

   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_in_reset();

   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_post_reset();

   /**
    * Creates trn by sampling #mp signals.
    */
   extern virtual task sample_trn(output uvma_${name}_mon_trn_c trn);

   /**
    * Appends #cfg, prints out trn and resets heartbeat monitor.
    */
   extern virtual function void process_trn(ref uvma_${name}_mon_trn_c trn);

endclass : uvma_${name}_mon_c


function uvma_${name}_mon_c::new(string name="uvma_${name}_mon", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_${name}_mon_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_MON", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_MON", "Context handle is null")
   end

   ap = new("ap", this);
   mp = cntxt.vif.mon_mp;

endfunction : build_phase


task uvma_${name}_mon_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   if (cfg.enabled) begin
      cntxt.sample_cntxt_e.trigger();

      fork
         observe_reset();
         forever begin
            case (cntxt.reset_state)
               UVML_RESET_STATE_PRE_RESET : mon_pre_reset ();
               UVML_RESET_STATE_IN_RESET  : mon_in_reset  ();
               UVML_RESET_STATE_POST_RESET: mon_post_reset();
            endcase
         end
      join_none
   end

endtask : run_phase


task uvma_${name}_mon_c::observe_reset();

   case (cfg.reset_type)
      UVML_RESET_TYPE_SYNCHRONOUS : observe_reset_sync ();
      UVML_RESET_TYPE_ASYNCHRONOUS: observe_reset_async();
      default: begin
         `uvm_fatal("${name_uppercase}_MON", $sformatf("Illegal cfg.reset_type: %s", cfg.reset_type.name()))
      end
   endcase

endtask : observe_reset


task uvma_${name}_mon_c::observe_reset_sync();

   forever begin
      `uvm_info("${name_uppercase}_MON", "Waiting for synchronous reset pulse", UVM_HIGH)
      while (mp.reset_n !== 1'b0) begin
         wait (mp.clk === 1);
         wait (mp.clk === 0);
      end

      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      cntxt.sample_cntxt_e.trigger();
      `uvm_info("${name_uppercase}_MON", "Entered IN_RESET state", UVM_HIGH)
      while (mp.reset_n !== 1'b1) begin
         wait (mp.clk === 1);
         wait (mp.clk === 0);
      end

      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      cntxt.sample_cntxt_e.trigger();
      `uvm_info("${name_uppercase}_MON", "Entered POST_RESET state", UVM_HIGH)
   end

endtask : observe_reset_sync


task uvma_${name}_mon_c::observe_reset_async();

   forever begin
      `uvm_info("${name_uppercase}_MON", "Waiting for asynchronous reset pulse", UVM_HIGH)
      wait (mp.reset_n === 0);

      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      cntxt.sample_cntxt_e.trigger();
      `uvm_info("${name_uppercase}_MON", "Entered IN_RESET state", UVM_HIGH)
      wait (mp.reset_n === 1);

      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      cntxt.sample_cntxt_e.trigger();
      `uvm_info("${name_uppercase}_MON", "Entered POST_RESET state", UVM_HIGH)
   end

endtask : observe_reset_async


task uvma_${name}_mon_c::mon_pre_reset();

   @(mp.mon_cb);

endtask : mon_pre_reset


task uvma_${name}_mon_c::mon_in_reset();

   @(mp.mon_cb);

endtask : mon_in_reset


task uvma_${name}_mon_c::mon_post_reset();

   uvma_${name}_mon_trn_c  trn;

   sample_trn (trn);
   process_trn(trn);
   ap.write   (trn);

endtask : mon_post_reset


task uvma_${name}_mon_c::sample_trn(output uvma_${name}_mon_trn_c trn);

   bit  sampled_trn = 0;

   do begin
      @(cntxt.vif.mon_cb);
      // TODO Sample trn from vif
      //      Ex: if (mp.mon_cb.enable === 1'b1) begin
      //             `uvm_info("${name_uppercase}_MON", "Sampling transaction", UVM_HIGH)
      //             trn = uvma_${name}_mon_trn_c::type_id::create("trn");
      //             sampled_trn = 1;
      //             trn.data = mp.mon_cb.data;
      //             trn.set_timestamp_end($realtime());
      //          end
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);

endtask : sample_trn


function void uvma_${name}_mon_c::process_trn(ref uvma_${name}_mon_trn_c trn);

   trn.cfg = cfg;
   trn.set_initiator(this);
   `uvm_info("${name_uppercase}_MON", $sformatf("Sampled transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)
   `uvml_hrtbt()

endfunction : process_trn


`endif // __UVMA_${name_uppercase}_MON_SV__

// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_${name_uppercase}_DP_MON_SV__
`define __UVMA_${name_uppercase}_DP_MON_SV__


/**
 * Component sampling transactions from ${name_normal_case} Data Path virtual interface (uvma_${name}_dp_if).
 */
class uvma_${name}_dp_mon_c extends uvml_mon_c;

   /// @defgroup Objects
   /// @{
   uvma_${name}_dp_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_dp_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_port#(uvma_${name}_dp_mon_in_trn_c )  in_ap ; ///< Port producing sampled input transactions.
   uvm_analysis_port#(uvma_${name}_dp_mon_out_trn_c)  out_ap; ///< Port producing sampled output transactions.
   /// @}

   /// @defgroup Interface handles
   /// @{
   virtual uvma_${name}_dp_if.mon_in_mp   mp_in ; ///< Handle to monitor modport for input data
   virtual uvma_${name}_dp_if.mon_out_mp  mp_out; ///< Handle to monitor modport for output data
   /// @}


   `uvm_component_utils_begin(uvma_${name}_dp_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_dp_mon", uvm_component parent=null);

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
   extern virtual task mon_in_pre_reset ();
   extern virtual task mon_out_pre_reset();

   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_in_in_reset ();
   extern virtual task mon_out_in_reset();

   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_in_post_reset ();
   extern virtual task mon_out_post_reset();

   /**
    * Creates trn by sampling #mp_in signals.
    */
   extern virtual task sample_in_trn(output uvma_${name}_dp_mon_in_trn_c trn);

   /**
    * Creates trn by sampling #mp_out signals.
    */
   extern virtual task sample_out_trn(output uvma_${name}_dp_mon_out_trn_c trn);

   /**
    * Appends #cfg, prints out trn and resets heartbeat monitor.
    */
   extern virtual function void process_in_trn(ref uvma_${name}_dp_mon_in_trn_c trn);

   /**
    * Appends #cfg, prints out trn and resets heartbeat monitor.
    */
   extern virtual function void process_out_trn(ref uvma_${name}_dp_mon_out_trn_c trn);

endclass : uvma_${name}_dp_mon_c


function uvma_${name}_dp_mon_c::new(string name="uvma_${name}_dp_mon", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_${name}_dp_mon_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_${name}_dp_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("${name_uppercase}_MON", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_${name}_dp_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("${name_uppercase}_MON", "Context handle is null")
   end

   in_ap  = new("in_ap" , this);
   out_ap = new("out_ap", this);
   mp_in  = cntxt.vif.mon_in_mp ;
   mp_out = cntxt.vif.mon_out_mp;

endfunction : build_phase


task uvma_${name}_dp_mon_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   if (cfg.enabled) begin
      cntxt.sample_cntxt_e.trigger();

      fork
         observe_reset();

         forever begin
            case (cntxt.reset_state)
               UVML_RESET_STATE_PRE_RESET : mon_in_pre_reset ();
               UVML_RESET_STATE_IN_RESET  : mon_in_in_reset  ();
               UVML_RESET_STATE_POST_RESET: mon_in_post_reset();
            endcase
         end

         forever begin
            case (cntxt.reset_state)
               UVML_RESET_STATE_PRE_RESET : mon_out_pre_reset ();
               UVML_RESET_STATE_IN_RESET  : mon_out_in_reset  ();
               UVML_RESET_STATE_POST_RESET: mon_out_post_reset();
            endcase
         end
      join_none
   end

endtask : run_phase


task uvma_${name}_dp_mon_c::observe_reset();

   case (cfg.reset_type)
      UVML_RESET_TYPE_SYNCHRONOUS : observe_reset_sync ();
      UVML_RESET_TYPE_ASYNCHRONOUS: observe_reset_async();
      default: begin
         `uvm_fatal("${name_uppercase}_MON", $sformatf("Illegal cfg.reset_type: %s", cfg.reset_type.name()))
      end
   endcase

endtask : observe_reset


task uvma_${name}_dp_mon_c::observe_reset_sync();

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


task uvma_${name}_dp_mon_c::observe_reset_async();

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


task uvma_${name}_dp_mon_c::mon_in_pre_reset();

   @(mp_in.mon_in_cb);

endtask : mon_in_pre_reset


task uvma_${name}_dp_mon_c::mon_out_pre_reset();

   @(mp_out.mon_out_cb);

endtask : mon_out_pre_reset


task uvma_${name}_dp_mon_c::mon_in_in_reset();

   @(mp_in.mon_in_cb);

endtask : mon_in_in_reset


task uvma_${name}_dp_mon_c::mon_out_in_reset();

   @(mp_out.mon_out_cb);

endtask : mon_out_in_reset


task uvma_${name}_dp_mon_c::mon_in_post_reset();

   uvma_${name}_dp_mon_in_trn_c  trn;

   sample_in_trn (trn);
   process_in_trn(trn);
   in_ap.write   (trn);

endtask : mon_in_post_reset


task uvma_${name}_dp_mon_c::mon_out_post_reset();

   uvma_${name}_dp_mon_out_trn_c  trn;

   sample_out_trn (trn);
   process_out_trn(trn);
   out_ap.write   (trn);

endtask : mon_out_post_reset


task uvma_${name}_dp_mon_c::sample_in_trn(output uvma_${name}_dp_mon_in_trn_c trn);

   bit  sampled_trn = 0;

   do begin
      @(mp_in.mon_in_cb);
      // TODO Sample trn
      //      Ex: if (mp_in.mon_in_cb.enable === 1'b1) begin
      //             `uvm_info("${name_uppercase}_MON", "Sampling transaction", UVM_DEBUG)
      //             trn = uvma_${name}_dp_mon_in_trn_c::type_id::create("trn");
      //             sampled_trn = 1;
      //             trn.data = mp_in.mon_in_cb.data;
      //             trn.set_timestamp_end($realtime());
      //          end
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);

endtask : sample_in_trn


task uvma_${name}_dp_mon_c::sample_out_trn(output uvma_${name}_dp_mon_out_trn_c trn);

   bit  sampled_trn = 0;

   do begin
      @(mp_in.mon_out_cb);
      // TODO Sample trn
      //      Ex: if (mp_out.mon_out_cb.enable === 1'b1) begin
      //             `uvm_info("${name_uppercase}_MON", "Sampling transaction", UVM_DEBUG)
      //             trn = uvma_${name}_dp_mon_out_trn_c::type_id::create("trn");
      //             sampled_trn = 1;
      //             trn.data = mp_out.mon_out_cb.data;
      //             trn.set_timestamp_end($realtime());
      //          end
      // WARNING If no time is consumed by this loop, a zero-delay oscillation loop will occur and stall simulation
   end while (!sampled_trn);

endtask : sample_out_trn


function void uvma_${name}_dp_mon_c::process_in_trn(ref uvma_${name}_dp_mon_in_trn_c trn);

   trn.cfg = cfg;
   trn.set_initiator(this);
   `uvm_info("${name_uppercase}_MON", $sformatf("Sampled input transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)
   `uvml_hrtbt()

endfunction : process_in_trn


function void uvma_${name}_dp_mon_c::process_out_trn(ref uvma_${name}_dp_mon_out_trn_c trn);

   trn.cfg = cfg;
   trn.set_initiator(this);
   `uvm_info("${name_uppercase}_MON", $sformatf("Sampled output transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)
   `uvml_hrtbt()

endfunction : process_out_trn


`endif // __UVMA_${name_uppercase}_DP_MON_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MON_SV__
`define __UVMA_{{ upper(name) }}_MON_SV__


/**
 * Component sampling transactions from an {{ full_name }} (uvma_{{ name }}_if).
 */
class uvma_{{ name }}_mon_c extends uvml_mon_c;

   virtual uvma_{{ name }}_if.mon_mp  mp; ///< Handle to A modport

   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle

   // TLM
   uvm_analysis_port#(uvma_{{ name }}_{{ tx }}_mon_trn_c)  {{ tx }}_ap; ///< TODO Describe uvma_{{ name }}_mon_c::{{ tx }}_ap
   uvm_analysis_port#(uvma_{{ name }}_{{ rx }}_mon_trn_c)  {{ rx }}_ap; ///< TODO Describe uvma_{{ name }}_mon_c::{{ rx }}_ap


   `uvm_component_utils_begin(uvma_{{ name }}_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Oversees monitoring, depending on the reset state, by calling mon_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Updates the context's reset state.
    */
   extern virtual task mon_reset();

   /**
    * Synchronous reset thread.
    */
   extern virtual task mon_reset_sync();

   /**
    * Asynchronous reset thread.
    */
   extern virtual task mon_reset_async();

   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_{{ tx }}_pre_reset();

   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_{{ rx }}_pre_reset();

   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_{{ tx }}_in_reset();

   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_{{ rx }}_in_reset();

   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_{{ tx }}_post_reset();

   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_{{ rx }}_post_reset();

   /**
    * Creates trn by sampling the virtual interface's (cntxt.vif) signals.
    */
   extern virtual task sample_{{ tx }}_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);

   /**
    * Creates trn by sampling the virtual interface's (cntxt.vif) signals.
    */
   extern virtual task sample_{{ rx }}_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);

   /**
    * Appends cfg, prints out trn and issues heartbeat.
    */
   extern virtual function void process_{{ tx }}_trn(ref uvma_{{ name }}_{{ tx }}_mon_trn_c trn);

   /**
    * Appends cfg, prints out trn and issues heartbeat.
    */
   extern virtual function void process_{{ rx }}_trn(ref uvma_{{ name }}_{{ rx }}_mon_trn_c trn);

endclass : uvma_{{ name }}_mon_c


function uvma_{{ name }}_mon_c::new(string name="uvma_{{ name }}_mon", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_mon_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end

   mp     = cntxt.vif.mon_mp;
   {{ tx }}_ap = new("{{ tx }}_ap", this);
   {{ rx }}_ap = new("{{ rx }}_ap", this);

endfunction : build_phase


task uvma_{{ name }}_mon_c::run_phase(uvm_phase phase);

   super.run_phase(phase);

   if (cfg.enabled) begin
      fork
         mon_reset();
         mon_tx   ();
         mon_rx   ();
      join_none
   end

endtask : run_phase


task uvma_{{ name }}_mon_c::mon_reset();

   case (cfg.reset_type)
      UVML_RESET_TYPE_SYNCHRONOUS : mon_reset_sync ();
      UVML_RESET_TYPE_ASYNCHRONOUS: mon_reset_async();

      default: begin
         `uvm_fatal("{{ upper(name) }}_MON", $sformatf("Illegal cfg.reset_type: %s", cfg.reset_type.name()))
      end
   endcase

endtask : mon_reset


task uvma_{{ name }}_mon_c::mon_reset_sync();

   forever begin
      while (cntxt.vif.reset_n !== 1'b0) begin
         wait (cntxt.vif.clk === 0);
         wait (cntxt.vif.clk === 1);
      end
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("{{ upper(name) }}_MON", "Entered IN_RESET state", UVM_MEDIUM)
      cntxt.reset();

      while (cntxt.vif.reset_n !== 1'b1) begin
         wait (cntxt.vif.clk === 0);
         wait (cntxt.vif.clk === 1);
      end
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("{{ upper(name) }}_MON", "Entered POST_RESET state", UVM_MEDIUM)
   end

endtask : mon_reset_sync


task uvma_{{ name }}_mon_c::mon_reset_async();

   forever begin
      wait (cntxt.vif.reset_n === 0);
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("{{ upper(name) }}_MON", "Entered IN_RESET state", UVM_MEDIUM)
      cntxt.reset();

      wait (cntxt.vif.reset_n === 1);
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("{{ upper(name) }}_MON", "Entered POST_RESET state", UVM_MEDIUM)
   end

endtask : mon_reset_async


task uvma_{{ name }}_mon_c::mon_{{ tx }}();

   forever begin
      case (cntxt.reset_state)
         UVML_RESET_STATE_PRE_RESET : mon_{{ tx }}_pre_reset ();
         UVML_RESET_STATE_IN_RESET  : mon_{{ tx }}_in_reset  ();
         UVML_RESET_STATE_POST_RESET: mon_{{ tx }}_post_reset();
      endcase
   end

endtask : mon_{{ tx }}


task uvma_{{ name }}_mon_c::mon_{{ rx }}();

   forever begin
      case (cntxt.reset_state)
         UVML_RESET_STATE_PRE_RESET : mon_{{ rx }}_pre_reset ();
         UVML_RESET_STATE_IN_RESET  : mon_{{ rx }}_in_reset  ();
         UVML_RESET_STATE_POST_RESET: mon_{{ rx }}_post_reset();
      endcase
   end

endtask : mon_{{ rx }}


task uvma_{{ name }}_mon_c::mon_{{ tx }}_pre_reset();

   @(mp.mon_cb);

endtask : mon_{{ tx }}_pre_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_pre_reset();

   @(mp.mon_cb);

endtask : mon_{{ rx }}_pre_reset


task uvma_{{ name }}_mon_c::mon_{{ tx }}_in_reset();

   @(mp.mon_cb);

endtask : mon_{{ tx }}_in_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_in_reset();

   @(mp.mon_cb);

endtask : mon_{{ rx }}_in_reset


task uvma_{{ name }}_mon_c::mon_{{ tx }}_post_reset();

   uvma_{{ name }}_{{ tx }}_mon_trn_c  trn;
   wait(mp.clk === 1);
   sample_{{ tx }}_trn (trn);
   process_{{ tx }}_trn(trn);
   {{ tx }}_ap.write   (trn);
   wait(mp.clk === 0);
   sample_{{ tx }}_trn (trn);
   process_{{ tx }}_trn(trn);
   {{ tx }}_ap.write   (trn);

endtask : mon_{{ tx }}_post_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_post_reset();

   uvma_{{ name }}_{{ rx }}_mon_trn_c  trn;
   wait(mp.clk === 1);
   sample_{{ rx }}_trn (trn);
   process_{{ rx }}_trn(trn);
   {{ rx }}_ap.write   (trn);
   wait(mp.clk === 0);
   sample_{{ rx }}_trn (trn);
   process_{{ rx }}_trn(trn);
   {{ rx }}_ap.write   (trn);

endtask : mon_{{ rx }}_post_reset


task uvma_{{ name }}_mon_c::sample_{{ tx }}_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);

   @(mp.mon_cb);
   `uvm_info("{{ upper(name) }}_MON", "Sampling Tx transaction", UVM_DEBUG)
   trn = uvma_{{ name }}_{{ tx }}_mon_trn_c::type_id::create("trn");
   trn.txdp = mp.mon_cb.txdp;
   trn.txdn = mp.mon_cb.txdn;

endtask : sample_{{ tx }}_trn


task uvma_{{ name }}_mon_c::sample_{{ rx }}_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);

   @(mp.mon_cb);
   `uvm_info("{{ upper(name) }}_MON", "Sampling Rx transaction", UVM_DEBUG)
   trn = uvma_{{ name }}_{{ rx }}_mon_trn_c::type_id::create("trn");
   trn.rxd24p = mp.mon_cb.rxd24p;
   trn.rxd24n = mp.mon_cb.rxd24n;
   trn.rxd09p = mp.mon_cb.rxd09p;
   trn.rxd09n = mp.mon_cb.rxd09n;

endtask : sample_{{ rx }}_trn


function void uvma_{{ name }}_mon_c::process_{{ tx }}_trn(ref uvma_{{ name }}_{{ tx }}_mon_trn_c trn);

   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("{{ upper(name) }}_MON", $sformatf("Sampled Tx transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)

endfunction : process_{{ tx }}_trn


function void uvma_{{ name }}_mon_c::process_{{ rx }}_trn(ref uvma_{{ name }}_{{ rx }}_mon_trn_c trn);

   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("{{ upper(name) }}_MON", $sformatf("Sampled Rx transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)

endfunction : process_{{ rx }}_trn


`endif // __UVMA_{{ upper(name) }}_MON_SV__

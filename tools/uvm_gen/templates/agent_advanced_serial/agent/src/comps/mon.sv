// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_MON_SV__
`define __UVMA_{{ name.upper() }}_MON_SV__


/**
 * Monitor sampling Phy Monitor Transactions from {{ full_name }} Interface (uvma_{{ name }}_if).
 * Also observes reset and updates the reset state in #cntxt.
 */
class uvma_{{ name }}_mon_c extends uvml_mon_c;

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup Virtual Interface handles
   /// @{
   virtual uvma_{{ name }}_if.mon_{{ tx }}_mp  {{ tx }}_mp; ///< Handle to {{ tx.upper() }} modport
   virtual uvma_{{ name }}_if.mon_{{ rx }}_mp  {{ rx }}_mp; ///< Handle to {{ rx.upper() }} modport
   /// @}

   /// @defgroup TLM
   /// @{
{% if symmetric %}   uvm_analysis_port #(uvma_{{ name }}_phy_mon_trn_c)  {{ tx }}_ap; ///< Port outputting {{ tx.upper() }} Phy Monitor transactions.
   uvm_analysis_port #(uvma_{{ name }}_phy_mon_trn_c)  {{ rx }}_ap; ///< Port outputting {{ rx.upper() }} Phy Monitor transactions.
{% else %}   uvm_analysis_port #(uvma_{{ name }}_{{ tx }}_mon_trn_c)  {{ tx }}_ap; ///< Port outputting {{ tx.upper() }} Phy Monitor transactions.
   uvm_analysis_port #(uvma_{{ name }}_{{ rx }}_mon_trn_c)  {{ rx }}_ap; ///< Port outputting {{ rx.upper() }} Phy Monitor transactions.
{% endif %}   /// @}


   `uvm_component_utils_begin(uvma_{{ name }}_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_mon", uvm_component parent=null);

   /**
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Builds TLM Ports.
    * 3. Retrieves modport handles from #cntxt.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Infinite loop sampling a Phy Monitor Transaction in each direction at each clock cycle.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt.
    */
   extern function void get_cntxt();

   /**
    * Creates #{{ tx }}_ap & #{{ rx }}_ap.
    */
   extern function void create_tlm_ports();

   /**
    * Retrieves #{{ tx }}_mp & #{{ rx }}_mp from #cntxt.
    */
   extern function void retrieve_modports();

   /**
    * Updates the context's reset state.
    */
   extern task mon_reset();

   /**
    * Synchronous reset thread.
    */
   extern task mon_reset_sync();

   /**
    * Asynchronous reset thread.
    */
   extern task mon_reset_async();

   /**
    * Infinite loop that monitors #{{ tx }}_mp during run_phase().
    */
   extern task mon_{{ tx }}();

   /**
    * Infinite loop that monitors #{{ rx }}_mp during run_phase().
    */
   extern task mon_{{ rx }}();

   /**
    * Waits out each {{ tx.upper() }} clock cycle before reset.
    */
   extern task mon_{{ tx }}_pre_reset();

   /**
    * Waits out each {{ rx.upper() }} clock cycle before reset.
    */
   extern task mon_{{ rx }}_pre_reset();

   /**
    * Waits out each {{ tx.upper() }} clock cycle during reset.
    */
   extern task mon_{{ tx }}_in_reset();

   /**
    * Waits out each {{ rx.upper() }} clock cycle during reset.
    */
   extern task mon_{{ rx }}_in_reset();

   /**
    * Samples #{{ tx }}_mp after reset.
    */
   extern task mon_{{ tx }}_post_reset();

   /**
    * Samples #{{ rx }}_mp after reset.
    */
   extern task mon_{{ rx }}_post_reset();

   /**
    * Creates {{ tx.upper() }} Phy Monitor Transaction by sampling #{{ tx }}_mp signals.
    */
{% if symmetric %}   extern task sample_{{ tx }}_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern task sample_{{ tx }}_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   /**
    * Creates {{ rx.upper() }} Phy Monitor Transaction by sampling #{{ rx }}_mp signals.
    */
{% if symmetric %}   extern task sample_{{ rx }}_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern task sample_{{ rx }}_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
   /**
    * Appends #cfg to #trn and prints it out.
    */
{% if symmetric %}   extern function void process_{{ tx }}_trn(ref uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern function void process_{{ tx }}_trn(ref uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   /**
    * Appends #cfg to #trn and prints it out.
    */
{% if symmetric %}   extern function void process_{{ rx }}_trn(ref uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}   extern function void process_{{ rx }}_trn(ref uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
endclass : uvma_{{ name }}_mon_c


function uvma_{{ name }}_mon_c::new(string name="uvma_{{ name }}_mon", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_mon_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg          ();
   get_cntxt        ();
   create_tlm_ports ();
   retrieve_modports();

endfunction : build_phase


task uvma_{{ name }}_mon_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   if (cfg.enabled) begin
      fork
         mon_reset();
         mon_{{ tx }}();
         mon_{{ rx }}();
      join_none
   end

endtask : run_phase


function void uvma_{{ name }}_mon_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_MON", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_mon_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_MON", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_mon_c::create_tlm_ports();

   {{ tx }}_ap = new("{{ tx }}_ap", this);
   {{ rx }}_ap = new("{{ rx }}_ap", this);

endfunction : create_tlm_ports


function void uvma_{{ name }}_mon_c::retrieve_modports();

   {{ tx }}_mp = cntxt.vif.mon_{{ tx }}_mp;
   {{ rx }}_mp = cntxt.vif.mon_{{ rx }}_mp;

endfunction : retrieve_modports


task uvma_{{ name }}_mon_c::mon_reset();

   case (cfg.reset_type)
      UVML_RESET_TYPE_SYNCHRONOUS : mon_reset_sync ();
      UVML_RESET_TYPE_ASYNCHRONOUS: mon_reset_async();
      default: begin
         `uvm_fatal("{{ name.upper() }}_MON", $sformatf("Illegal cfg.reset_type: %s", cfg.reset_type.name()))
      end
   endcase

endtask : mon_reset


task uvma_{{ name }}_mon_c::mon_reset_sync();

   forever begin
      while (cntxt.vif.reset_n !== 1'b0) begin
         fork
            begin
               wait (cntxt.vif.{{ tx }}_clk === 0);
               wait (cntxt.vif.{{ tx }}_clk === 1);
            end
            begin
               wait (cntxt.vif.{{ rx }}_clk === 0);
               wait (cntxt.vif.{{ rx }}_clk === 1);
            end
         join
      end
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("{{ name.upper() }}_MON", "Entered IN_RESET state", UVM_MEDIUM)
      cntxt.reset();
      while (cntxt.vif.reset_n !== 1'b1) begin
         fork
            begin
               wait (cntxt.vif.{{ tx }}_clk === 0);
               wait (cntxt.vif.{{ tx }}_clk === 1);
            end
            begin
               wait (cntxt.vif.{{ rx }}_clk === 0);
               wait (cntxt.vif.{{ rx }}_clk === 1);
            end
         join
      end
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("{{ name.upper() }}_MON", "Entered POST_RESET state", UVM_MEDIUM)
   end

endtask : mon_reset_sync


task uvma_{{ name }}_mon_c::mon_reset_async();

   forever begin
      wait (cntxt.vif.reset_n === 0);
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("{{ name.upper() }}_MON", "Entered IN_RESET state", UVM_MEDIUM)
      cntxt.reset();
      wait (cntxt.vif.reset_n === 1);
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("{{ name.upper() }}_MON", "Entered POST_RESET state", UVM_MEDIUM)
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
   @({{ tx }}_mp.mon_{{ tx }}_cb);
endtask : mon_{{ tx }}_pre_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_pre_reset();
   @({{ rx }}_mp.mon_{{ rx }}_cb);
endtask : mon_{{ rx }}_pre_reset


task uvma_{{ name }}_mon_c::mon_{{ tx }}_in_reset();
   @({{ tx }}_mp.mon_{{ tx }}_cb);
endtask : mon_{{ tx }}_in_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_in_reset();
   @({{ rx }}_mp.mon_{{ rx }}_cb);
endtask : mon_{{ rx }}_in_reset


task uvma_{{ name }}_mon_c::mon_{{ tx }}_post_reset();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  trn;
{% else %}   uvma_{{ name }}_{{ tx }}_mon_trn_c  trn;
{% endif %}
   sample_{{ tx }}_trn (trn);
   process_{{ tx }}_trn(trn);
   {{ tx }}_ap.write   (trn);

endtask : mon_{{ tx }}_post_reset


task uvma_{{ name }}_mon_c::mon_{{ rx }}_post_reset();

{% if symmetric %}   uvma_{{ name }}_phy_mon_trn_c  trn;
{% else %}   uvma_{{ name }}_{{ rx }}_mon_trn_c  trn;
{% endif %}
   sample_{{ rx }}_trn (trn);
   process_{{ rx }}_trn(trn);
   {{ rx }}_ap.write   (trn);

endtask : mon_{{ rx }}_post_reset


{% if symmetric %}task uvma_{{ name }}_mon_c::sample_{{ tx }}_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}task uvma_{{ name }}_mon_c::sample_{{ tx }}_trn(output uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   @({{ tx }}_mp.mon_{{ tx }}_cb);
   `uvm_info("{{ name.upper() }}_MON_{{ tx.upper() }}", "Sampling Phy transaction", UVM_DEBUG)
{% if symmetric %}   trn = uvma_{{ name }}_phy_mon_trn_c::type_id::create("trn");
   trn.dp = {{ tx }}_mp.mon_{{ tx }}_cb.{{ tx }}p;
   trn.dn = {{ tx }}_mp.mon_{{ tx }}_cb.{{ tx }}n;
{% else %}   trn = uvma_{{ name }}_{{ tx }}_mon_trn_c::type_id::create("trn");
   trn.{{ tx }}p = {{ tx }}_mp.mon_{{ tx }}_cb.{{ tx }}p;
   trn.{{ tx }}n = {{ tx }}_mp.mon_{{ tx }}_cb.{{ tx }}n;
{% endif %}
endtask : sample_{{ tx }}_trn


{% if symmetric %}task uvma_{{ name }}_mon_c::sample_{{ rx }}_trn(output uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}task uvma_{{ name }}_mon_c::sample_{{ rx }}_trn(output uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
   @({{ rx }}_mp.mon_{{ rx }}_cb);
   `uvm_info("{{ name.upper() }}_MON_{{ rx.upper() }}", "Sampling Phy transaction", UVM_DEBUG)
{% if symmetric %}   trn = uvma_{{ name }}_phy_mon_trn_c::type_id::create("trn");
   trn.dp = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}p;
   trn.dn = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}n;
{% else %}   trn = uvma_{{ name }}_{{ rx }}_mon_trn_c::type_id::create("trn");
   trn.{{ rx }}0p = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}0p;
   trn.{{ rx }}0n = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}0n;
   trn.{{ rx }}1p = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}1p;
   trn.{{ rx }}1n = {{ rx }}_mp.mon_{{ rx }}_cb.{{ rx }}1n;
{% endif %}
endtask : sample_{{ rx }}_trn


{% if symmetric %}function void uvma_{{ name }}_mon_c::process_{{ tx }}_trn(ref uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}function void uvma_{{ name }}_mon_c::process_{{ tx }}_trn(ref uvma_{{ name }}_{{ tx }}_mon_trn_c trn);
{% endif %}
   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("{{ name.upper() }}_MON_{{ tx.upper() }}", $sformatf("Sampled Phy transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)

endfunction : process_{{ tx }}_trn


{% if symmetric %}function void uvma_{{ name }}_mon_c::process_{{ rx }}_trn(ref uvma_{{ name }}_phy_mon_trn_c trn);
{% else %}function void uvma_{{ name }}_mon_c::process_{{ rx }}_trn(ref uvma_{{ name }}_{{ rx }}_mon_trn_c trn);
{% endif %}
   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("{{ name.upper() }}_MON_{{ rx.upper() }}", $sformatf("Sampled Phy transaction from the virtual interface:\n%s", trn.sprint()), UVM_DEBUG)

endfunction : process_{{ rx }}_trn


`endif // __UVMA_{{ name.upper() }}_MON_SV__

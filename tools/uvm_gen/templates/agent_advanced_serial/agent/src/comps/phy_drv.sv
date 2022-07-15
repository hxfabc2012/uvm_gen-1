// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_PHY_DRV_SV__
`define __UVMA_{{ name.upper() }}_PHY_DRV_SV__


/**
 * Component driving a {{ full_name }} virtual interface (uvma_{{ name }}_if).
 */
class uvma_{{ name }}_phy_drv_c extends uvml_drv_c #(
   .REQ(uvma_{{ name }}_phy_seq_item_c),
   .RSP(uvma_{{ name }}_phy_seq_item_c)
);

   virtual uvma_{{ name }}_if.drv_{{ tx }}_mp  {{ tx }}_mp; ///< Handle to virtual interface modport
   virtual uvma_{{ name }}_if.drv_{{ rx }}_mp  {{ rx }}_mp; ///< Handle to virtual interface modport

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup TLM
   /// @{
   uvm_analysis_port#(uvma_{{ name }}_phy_seq_item_c)  ap; ///<
   /// @}


   `uvm_component_utils_begin(uvma_{{ name }}_phy_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_{{ rx }}_drv", uvm_component parent=null);

   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Oversees driving, depending on the reset state, by calling drv_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);

   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_cfg();

   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_cntxt();

   /**
    * Appends cfg, prints out trn and issues heartbeat.
    */
   extern virtual function void process_req(ref uvma_{{ name }}_phy_seq_item_c req);

   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_req(ref uvma_{{ name }}_phy_seq_item_c req);

   /**
    * TODO Describe uvma_{{ name }}_phy_drv_c::sample_post_clk()
    */
   extern virtual task sample_post_clk(ref uvma_{{ name }}_phy_seq_item_c req);

endclass : uvma_{{ name }}_phy_drv_c


function uvma_{{ name }}_phy_drv_c::new(string name="uvma_{{ name }}_{{ rx }}_drv", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_phy_drv_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg  ();
   get_cntxt();

   ap = new("ap", this);
   mp = cntxt.vif.drv_{{ rx }}_mp;

endfunction : build_phase


task uvma_{{ name }}_phy_drv_c::run_phase(uvm_phase phase);

   super.run_phase(phase);
   if (cfg.enabled && cfg.is_active) begin
      forever begin
         seq_item_port.get_next_item(req);
         process_req                (req);
         drv_req                    (req);
         ap.write                   (req);
         seq_item_port.item_done();
      end
   end

endtask : run_phase


function void uvma_{{ name }}_phy_drv_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ name.upper() }}_PHY_DRV", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_phy_drv_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ name.upper() }}_PHY_DRV", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_phy_drv_c::process_req(ref uvma_{{ name }}_phy_seq_item_c req);

   req.cfg = cfg;
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_PHY_DRV", $sformatf("Got new req from the sequencer:\n%s", req.sprint()), UVM_DEBUG)

endfunction : process_req


task uvma_{{ name }}_phy_drv_c::drv_req(ref uvma_{{ name }}_phy_seq_item_c req);

   {% if ddr %}bit valid_edge = 0;
   do begin
      case (cfg.mode)
         UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: begin
            @({{ tx }}_mp.drv_{{ tx }}_cb);
            if ({{ tx }}_mp.{{ tx }}_clk inside {0,1}) begin
               valid_edge = 1;
               {{ tx }}_mp.drv_{{ tx }}_cb.txp <= req.dp;
               {{ tx }}_mp.drv_{{ tx }}_cb.txn <= req.dn;
            end
         end
         UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: begin
            @({{ rx }}_mp.drv_{{ rx }}_cb);
            if ({{ rx }}_mp.{{ rx }}_clk inside {0,1}) begin
               valid_edge = 1;
               {{ rx }}_mp.drv_{{ rx }}_cb.rxp <= req.dp;
               {{ rx }}_mp.drv_{{ rx }}_cb.rxn <= req.dn;
            end
         end
      endcase
   end while (!valid_edge);
{% else %}   case (cfg.mode)
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: begin
         @({{ tx }}_mp.drv_{{ tx }}_cb);
         {{ tx }}_mp.drv_{{ tx }}_cb.txp <= req.dp;
         {{ tx }}_mp.drv_{{ tx }}_cb.txn <= req.dn;
      end
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: begin
         @({{ rx }}_mp.drv_{{ rx }}_cb);
         {{ rx }}_mp.drv_{{ rx }}_cb.rxp <= req.dp;
         {{ rx }}_mp.drv_{{ rx }}_cb.rxn <= req.dn;
      end
   endcase
{% endif %}
endtask : drv_req


task uvma_{{ name }}_phy_drv_c::sample_post_clk(ref uvma_{{ name }}_phy_seq_item_c req);



endtask : sample_post_clk


`endif // __UVMA_{{ name.upper() }}_PHY_DRV_SV__

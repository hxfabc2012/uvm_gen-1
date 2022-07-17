// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_PHY_DRV_SV__
`define __UVMA_{{ name.upper() }}_PHY_DRV_SV__


/**
 * Driver driving {{ full_name }} Virtual Interface (uvma_{{ name }}_if) in either direction.
 */
class uvma_{{ name }}_phy_drv_c extends uvml_drv_c #(
   .REQ(uvma_{{ name }}_phy_seq_item_c),
   .RSP(uvma_{{ name }}_phy_seq_item_c)
);

   virtual uvma_{{ name }}_if.drv_{{ tx }}_mp  {{ tx }}_mp; ///< Handle to Virtual Interface {{ tx.upper() }} modport
   virtual uvma_{{ name }}_if.drv_{{ rx }}_mp  {{ rx }}_mp; ///< Handle to Virtual Interface {{ rx.upper() }} modport

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup TLM Ports
   /// @{
   uvm_analysis_port#(uvma_{{ name }}_phy_seq_item_c)  ap; ///< Port outputting Phy Sequence Items after they've been used to drive the Virtual Interface.
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
    * 1. Ensures #cfg & #cntxt handles are not null.
    * 2. Builds TLM Ports.
    * 3. Retrieves modport handles from #cntxt.
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * Infinite loop taking in #req and driving #mp on each clock cycle.
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
    * Creates #ap.
    */
   extern function void create_tlm_ports();

   /**
    * Retrieves #mp from #cntxt.
    */
   extern function void retrieve_modports();

   /**
    * Appends #cfg to #req and prints it out.
    */
   extern virtual function void process_req(ref uvma_{{ name }}_phy_seq_item_c req);

   /**
    * Drives #mp signals using #req's contents on the next clock cycle.
    */
   extern virtual task drv_req(ref uvma_{{ name }}_phy_seq_item_c req);

endclass : uvma_{{ name }}_phy_drv_c


function uvma_{{ name }}_phy_drv_c::new(string name="uvma_{{ name }}_{{ rx }}_drv", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_phy_drv_c::build_phase(uvm_phase phase);

   super.build_phase(phase);
   get_cfg          ();
   get_cntxt        ();
   create_tlm_ports ();
   retrieve_modports();

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


function void uvma_{{ name }}_{{ rx }}_drv_c::create_tlm_ports();

   ap = new("ap", this);

endfunction : create_tlm_ports


function void uvma_{{ name }}_{{ rx }}_drv_c::retrieve_modports();

   {{ tx }}_mp = cntxt.vif.drv_{{ tx }}_mp;
   {{ rx }}_mp = cntxt.vif.drv_{{ rx }}_mp;

endfunction : retrieve_modports


function void uvma_{{ name }}_phy_drv_c::process_req(ref uvma_{{ name }}_phy_seq_item_c req);

   req.cfg = cfg;
   `uvm_info("{{ name.upper() }}_{{ rx.upper() }}_PHY_DRV", $sformatf("Got new req from the sequencer:\n%s", req.sprint()), UVM_DEBUG)

endfunction : process_req


task uvma_{{ name }}_phy_drv_c::drv_req(ref uvma_{{ name }}_phy_seq_item_c req);

   {% if ddr %}bit valid_edge = 0;
   do begin
      case (cfg.drv_mode)
         UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: begin
            @({{ tx }}_mp.drv_{{ tx }}_cb);
            if ({{ tx }}_mp.{{ tx }}_clk inside {0,1}) begin
               valid_edge = 1;
               {{ tx }}_mp.drv_{{ tx }}_cb.{{ tx }}p <= req.dp;
               {{ tx }}_mp.drv_{{ tx }}_cb.{{ tx }}n <= req.dn;
            end
         end
         UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: begin
            @({{ rx }}_mp.drv_{{ rx }}_cb);
            if ({{ rx }}_mp.{{ rx }}_clk inside {0,1}) begin
               valid_edge = 1;
               {{ rx }}_mp.drv_{{ rx }}_cb.{{ rx }}p <= req.dp;
               {{ rx }}_mp.drv_{{ rx }}_cb.{{ rx }}n <= req.dn;
            end
         end
      endcase
   end while (!valid_edge);
{% else %}   case (cfg.drv_mode)
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}: begin
         @({{ tx }}_mp.drv_{{ tx }}_cb);
         {{ tx }}_mp.drv_{{ tx }}_cb.{{ tx }}p <= req.dp;
         {{ tx }}_mp.drv_{{ tx }}_cb.{{ tx }}n <= req.dn;
      end
      UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}: begin
         @({{ rx }}_mp.drv_{{ rx }}_cb);
         {{ rx }}_mp.drv_{{ rx }}_cb.{{ rx }}p <= req.dp;
         {{ rx }}_mp.drv_{{ rx }}_cb.{{ rx }}n <= req.dn;
      end
   endcase
{% endif %}
endtask : drv_req


`endif // __UVMA_{{ name.upper() }}_PHY_DRV_SV__

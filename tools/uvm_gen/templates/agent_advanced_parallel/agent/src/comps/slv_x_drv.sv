// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_SLV_A_DRV_SV__
`define __UVMA_{{ upper(name) }}_SLV_A_DRV_SV__


/**
 * Component driving a {{ full_name }} virtual interface (uvma_{{ name }}_if).
 */
class uvma_{{ name }}_slv_a_drv_c extends uvm_driver #(
   .REQ(uvma_{{ name }}_slv_a_seq_item_c),
   .RSP(uvma_{{ name }}_slv_a_seq_item_c)
);
   
   virtual uvma_{{ name }}_if.drv_slv_a_mp  mp; ///< Handle to virtual interface modport
   
   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   
   // TLM
   uvm_analysis_port#(uvma_{{ name }}_slv_a_seq_item_c)  ap; ///< 
   
   
   `uvm_component_utils_begin(uvma_{{ name }}_slv_a_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_slv_a_drv", uvm_component parent=null);
   
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
    * Appends cfg, prints out trn and issues heartbeat.
    */
   extern virtual function void process_req(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_req(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
   /**
    * TODO Describe uvma_{{ name }}_slv_a_drv_c::sample_post_clk()
    */
   extern virtual task sample_post_clk(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
endclass : uvma_{{ name }}_slv_a_drv_c


function uvma_{{ name }}_slv_a_drv_c::new(string name="uvma_{{ name }}_slv_a_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_{{ name }}_slv_a_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_SLV_A_DRV", "Configuration handle is null")
   end
   uvm_config_db#(uvma_{{ name }}_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_SLV_A_DRV", "Context handle is null")
   end
   uvm_config_db#(uvma_{{ name }}_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   ap = new("ap", this);
   mp = cntxt.vif.drv_slv_a_mp;
   
endfunction : build_phase


task uvma_{{ name }}_slv_a_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.is_active && (cfg.drv_mode == UVMA_{{ upper(name) }}_DRV_MODE_SLV)) begin
      forever begin
         seq_item_port.get_next_item(req);
         process_req                (req);
         drv_req                    (req);
         ap.write                   (req);
         
         @(mp.drv_slv_a_cb);
         sample_post_clk(req);
         seq_item_port.item_done();
      end
   end
   
endtask : run_phase


function void uvma_{{ name }}_slv_a_drv_c::process_req(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
   req.cfg = cfg;
   `uvm_info("{{ upper(name) }}_SLV_A_DRV", $sformatf("Got new req from the sequencer:\n%s", req.sprint()), UVM_HIGH)
   
endfunction : process_req


task uvma_{{ name }}_slv_a_drv_c::drv_req(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
   mp.drv_slv_a_cb.gnt    <= req.gnt   ;
   mp.drv_slv_a_cb.gntpar <= req.gntpar;
   
endtask : drv_req


task uvma_{{ name }}_slv_a_drv_c::sample_post_clk(ref uvma_{{ name }}_slv_a_seq_item_c req);
   
   req.req = mp.drv_slv_a_cb.req;
   
endtask : sample_post_clk


`endif // __UVMA_{{ upper(name) }}_SLV_A_DRV_SV__

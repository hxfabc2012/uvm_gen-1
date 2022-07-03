// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_VSQR_SV__
`define __UVMA_{{ upper(name) }}_VSQR_SV__


/**
 * Component running {{ full_name }} sequences extending uvma_{{ name }}_base_vseq_c.
 */
class uvma_{{ name }}_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvma_{{ name }}_seq_item_c),
   .RSP(uvma_{{ name }}_seq_item_c)
);

   // Objects
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle

   // Components
   uvma_{{ name }}_frame_sqr_c  frame_sequencer    ; ///< TODO Describe uvma_{{ name }}_vsqr_c::frame_sequencer
   uvma_{{ name }}_{{ tx }}_sqr_c     {{ tx }}_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::{{ tx }}_sequencer
   uvma_{{ name }}_{{ rx }}_sqr_c     {{ rx }}_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::{{ rx }}_sequencer

   // TLM
   uvm_seq_item_pull_port #(uvm_sequence_item)  upstream_sqr_port; ///< TODO Describe uvma_{{ name }}_vsqr_c::upstream_sqr_port
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c )  mon_trn_{{ tx }}_ap; ///< TODO Rename this
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c )  mon_trn_{{ rx }}_ap; ///< TODO Rename this
   uvm_analysis_port      #(uvma_{{ name }}_seq_item_c)  seq_item_ap ; ///< TODO Describe uvma_{{ name }}_vswr_c::seq_item_ap
   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_{{ tx }}_mon_trn_c)  {{ tx }}_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::{{ tx }}_mon_trn_fifo
   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_{{ rx }}_mon_trn_c)  {{ rx }}_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::{{ rx }}_mon_trn_fifo
   uvm_analysis_export    #(uvma_{{ name }}_{{ tx }}_mon_trn_c)  {{ tx }}_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::{{ tx }}_mon_trn_export
   uvm_analysis_export    #(uvma_{{ name }}_{{ rx }}_mon_trn_c)  {{ rx }}_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::{{ rx }}_mon_trn_export


   `uvm_component_utils_begin(uvma_{{ name }}_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_{{ name }}_vsqr", uvm_component parent=null);

   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);

   /**
    * TODO Describe uvma_{{ name }}_vsqr_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);

endclass : uvma_{{ name }}_vsqr_c


function uvma_{{ name }}_vsqr_c::new(string name="uvma_{{ name }}_vsqr", uvm_component parent=null);

   super.new(name, parent);

endfunction : new


function void uvma_{{ name }}_vsqr_c::build_phase(uvm_phase phase);

   super.build_phase(phase);

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_VSQR", "Configuration handle is null")
   end

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_VSQR", "Context handle is null")
   end

   // Create components
   frame_sequencer = uvma_{{ name }}_frame_sqr_c::type_id::create("frame_sequencer", this);
   {{ tx }}_sequencer = uvma_{{ name }}_{{ tx }}_sqr_c::type_id::create("{{ tx }}_sequencer", this);
   {{ rx }}_sequencer = uvma_{{ name }}_{{ rx }}_sqr_c::type_id::create("{{ rx }}_sequencer", this);

   // Create TLM objects
   upstream_sqr_port = new("upstream_sqr_port", this);
   mon_trn_{{ tx }}_ap = new("mon_trn_{{ tx }}_ap", this);
   mon_trn_{{ rx }}_ap = new("mon_trn_{{ rx }}_ap", this);
   seq_item_ap = new("seq_item_ap", this);
   {{ tx }}_mon_trn_fifo   = new("{{ tx }}_mon_trn_fifo"  , this);
   {{ rx }}_mon_trn_fifo   = new("{{ rx }}_mon_trn_fifo"  , this);
   {{ tx }}_mon_trn_export = new("{{ tx }}_mon_trn_export", this);
   {{ rx }}_mon_trn_export = new("{{ rx }}_mon_trn_export", this);

endfunction : build_phase


function void uvma_{{ name }}_vsqr_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   // Connect exports to FIFOs
   {{ tx }}_mon_trn_export.connect({{ tx }}_mon_trn_fifo.analysis_export);
   {{ rx }}_mon_trn_export.connect({{ rx }}_mon_trn_fifo.analysis_export);

endfunction : connect_phase


`endif // __UVMA_{{ upper(name) }}_VSQR_SV__

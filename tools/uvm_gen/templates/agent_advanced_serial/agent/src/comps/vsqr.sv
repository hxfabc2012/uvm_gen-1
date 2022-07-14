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

   /// @defgroup Objects
   /// @{
   uvma_{{ name }}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_{{ name }}_cntxt_c  cntxt; ///< Agent context handle
   /// @}

   /// @defgroup Components
   /// @{
{% if symmetric %}   uvma_{{ name }}_phy_sqr_c  tx_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::tx_sequencer
   uvma_{{ name }}_phy_sqr_c  rx_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::rx_sequencer
{% else %}   uvma_{{ name }}_tx_sqr_c  tx_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::tx_sequencer
   uvma_{{ name }}_rx_sqr_c  rx_sequencer; ///< TODO Describe uvma_{{ name }}_vsqr_c::rx_sequencer
{% endif %}   /// @}

   /// @defgroup TLM
   /// @{
   uvm_seq_item_pull_port #(uvm_sequence_item)  upstream_sqr_port; ///< TODO Describe uvma_{{ name }}_vsqr_c::upstream_sqr_port
   uvm_analysis_port      #(uvma_{{ name }}_seq_item_c)  seq_item_ap ; ///< TODO Describe uvma_{{ name }}_vswr_c::seq_item_ap
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c )  tx_mon_trn_ap; ///< TODO Rename this
   uvm_analysis_port      #(uvma_{{ name }}_mon_trn_c )  rx_mon_trn_ap; ///< TODO Rename this
{% if symmetric %}   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_phy_mon_trn_c)  tx_phy_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::tx_phy_mon_trn_fifo
   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_phy_mon_trn_c)  rx_phy_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::rx_phy_mon_trn_fifo
   uvm_analysis_export    #(uvma_{{ name }}_phy_mon_trn_c)  tx_phy_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::tx_phy_mon_trn_export
   uvm_analysis_export    #(uvma_{{ name }}_phy_mon_trn_c)  rx_phy_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::rx_phy_mon_trn_export
{% else %}   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_tx_mon_trn_c)  tx_phy_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::tx_phy_mon_trn_fifo
   uvm_tlm_analysis_fifo  #(uvma_{{ name }}_rx_mon_trn_c)  rx_phy_mon_trn_fifo  ; ///< TODO Describe uvma_{{ name }}_vswr_c::rx_phy_mon_trn_fifo
   uvm_analysis_export    #(uvma_{{ name }}_tx_mon_trn_c)  tx_phy_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::tx_phy_mon_trn_export
   uvm_analysis_export    #(uvma_{{ name }}_rx_mon_trn_c)  rx_phy_mon_trn_export; ///< TODO Describe uvma_{{ name }}_vswr_c::rx_phy_mon_trn_export
{% endif %}   /// @}


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

   get_cfg          ();
   get_cntxt        ();
   create_components();
   create_ports     ();

endfunction : build_phase


function void uvma_{{ name }}_vsqr_c::connect_phase(uvm_phase phase);

   super.connect_phase(phase);

   connect_fifos();

endfunction : connect_phase


function void uvma_{{ name }}_vsqr_c::get_cfg();

   void'(uvm_config_db#(uvma_{{ name }}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("{{ upper(name) }}_VSQR", "Configuration handle is null")
   end

endfunction : get_cfg


function void uvma_{{ name }}_vsqr_c::get_cntxt();

   void'(uvm_config_db#(uvma_{{ name }}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("{{ upper(name) }}_VSQR", "Context handle is null")
   end

endfunction : get_cntxt


function void uvma_{{ name }}_vsqr_c::create_components();

{% if %}   tx_sequencer = uvma_{{ name }}_phy_sqr_c::type_id::create("tx_sequencer", this);
   rx_sequencer = uvma_{{ name }}_phy_sqr_c::type_id::create("rx_sequencer", this);
{% else %}   tx_sequencer = uvma_{{ name }}_tx_sqr_c::type_id::create("tx_sequencer", this);
   rx_sequencer = uvma_{{ name }}_rx_sqr_c::type_id::create("rx_sequencer", this);
{% endif %}

endfunction : create_components


function void uvma_{{ name }}_vsqr_c::create_ports();

   upstream_sqr_port = new("upstream_sqr_port", this);
   seq_item_ap       = new("seq_item_ap", this);
   tx_mon_trn_ap         = new("tx_mon_trn_ap"        , this);
   rx_mon_trn_ap         = new("rx_mon_trn_ap"        , this);
   tx_phy_mon_trn_fifo   = new("tx_phy_mon_trn_fifo"  , this);
   rx_phy_mon_trn_fifo   = new("rx_phy_mon_trn_fifo"  , this);
   tx_phy_mon_trn_export = new("tx_phy_mon_trn_export", this);
   rx_phy_mon_trn_export = new("rx_phy_mon_trn_export", this);

endfunction : create_ports


function void uvma_{{ name }}_vsqr_c::connect_fifos();

   tx_phy_mon_trn_export.connect(tx_phy_mon_trn_fifo.analysis_export);
   rx_phy_mon_trn_export.connect(rx_phy_mon_trn_fifo.analysis_export);

endfunction : connect_fifos


`endif // __UVMA_{{ upper(name) }}_VSQR_SV__

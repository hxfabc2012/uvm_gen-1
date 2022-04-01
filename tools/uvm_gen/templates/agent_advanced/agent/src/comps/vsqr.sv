// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_${name_uppercase}_VSQR_SV__
`define __UVMA_${name_uppercase}_VSQR_SV__


/**
 * Component running Open Bus Interface sequences extending uvma_${name}_base_vseq_c.
 */
class uvma_${name}_vsqr_c extends uvm_sequencer #(
   .REQ(uvma_${name}_seq_item_c),
   .RSP(uvma_${name}_seq_item_c)
);
   
   // Objects
   uvma_${name}_cfg_c    cfg  ; ///< Agent configuration handle
   uvma_${name}_cntxt_c  cntxt; ///< Agent context handle
   
   // Components
   uvma_${name}_mstr_a_sqr_c  mstr_sequencer; ///< TODO Describe uvma_${name}_vsqr_c::mstr_a_sequencer
   uvma_${name}_slv_a_sqr_c   slv_sequencer ; ///< TODO Describe uvma_${name}_vsqr_c::slv_a_sequencer
   
   // TLM
   uvm_seq_item_pull_port #(uvm_sequence_item)  upstream_suquencer_port    ; ///< TODO Describe uvma_${name}_vsqr_c::upstream_suquencer_port
   uvm_analysis_port      #(uvma_${name}_mon_trn_c)  ${main}_mon_trn_ap           ; ///< TODO Describe uvma_${name}_vswr_c::${main}_mon_trn_ap           
   uvm_analysis_port      #(uvma_${name}_mon_trn_c       )  ${sec}_mon_trn_ap           ; ///< TODO Describe uvma_${name}_vswr_c::${sec}_mon_trn_ap           
   uvm_analysis_port      #(uvma_${name}_${main}_seq_item_c      )  ${main}_seq_item_ap          ; ///< TODO Describe uvma_${name}_vswr_c::seq_item_ap          
   uvm_analysis_port      #(uvma_${name}_${sec}_seq_item_c      )  ${sec}_seq_item_ap          ; ///< TODO Describe uvma_${name}_vswr_c::seq_item_ap          
   uvm_tlm_analysis_fifo  #(uvma_${name}_mstr_a_mon_trn_c)  mstr_a_mon_trn_fifo  ; ///< TODO Describe uvma_${name}_vswr_c::mstr_a_mon_trn_fifo  
   uvm_tlm_analysis_fifo  #(uvma_${name}_slv_a_mon_trn_c )  slv_a_mon_trn_fifo   ; ///< TODO Describe uvma_${name}_vswr_c::slv_a_mon_trn_fifo   
   uvm_analysis_export    #(uvma_${name}_mstr_a_mon_trn_c)  mstr_a_mon_trn_export; ///< TODO Describe uvma_${name}_vswr_c::mstr_a_mon_trn_export
   uvm_analysis_export    #(uvma_${name}_slv_a_mon_trn_c )  slv_a_mon_trn_export ; ///< TODO Describe uvma_${name}_vswr_c::slv_a_mon_trn_export 
   
   
   `uvm_component_utils_begin(uvma_${name}_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_${name}_vsqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_${name}_vsqr_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_${name}_vsqr_c


function uvma_${name}_vsqr_c::new(string name="uvma_${name}_vsqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_${name}_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_${name}_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("${name_uppercase}_VSQR", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_${name}_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("${name_uppercase}_VSQR", "Context handle is null")
   end
   
   // Create components
   mstr_a_sequencer = uvma_${name}_mstr_a_sqr_c::type_id::create("mstr_a_sequencer", this);
   slv_a_sequencer  = uvma_${name}_slv_a_sqr_c ::type_id::create("slv_a_sequencer" , this);
   
   // Create TLM objects
   upstream_suquencer_port     = new("upstream_suquencer_port"    , this);
   mon_trn_ap            = new("mon_trn_ap"           , this);
   seq_item_ap           = new("seq_item_ap"          , this);
   mstr_a_mon_trn_fifo   = new("mstr_a_mon_trn_fifo"  , this);
   slv_a_mon_trn_fifo    = new("slv_a_mon_trn_fifo"   , this);
   mstr_a_mon_trn_export = new("mstr_a_mon_trn_export", this);
   slv_a_mon_trn_export  = new("slv_a_mon_trn_export" , this);
   
endfunction : build_phase


function void uvma_${name}_vsqr_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect exports to FIFOs
   mstr_a_mon_trn_export.connect(mstr_a_mon_trn_fifo.analysis_export);
   slv_a_mon_trn_export .connect(slv_a_mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


`endif // __UVMA_${name_uppercase}_VSQR_SV__

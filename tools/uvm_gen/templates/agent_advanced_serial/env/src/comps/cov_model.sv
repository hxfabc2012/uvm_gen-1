// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ name.upper() }}_ST_COV_MODEL_SV__
`define __UVME_{{ name.upper() }}_ST_COV_MODEL_SV__


/**
 * Component encapsulating {{ full_name }} Self-Test Environment functional coverage model.
 */
class uvme_{{ name }}_st_cov_model_c extends uvma_{{ name }}_cov_model_c;


   `uvm_component_utils(uvme_{{ name }}_st_cov_model_c)


   /**
    *
    */
   covergroup {{ name }}_st_cfg_cg;
      bypass_mode_cpt     : coverpoint cfg.bypass_mode    ;
      is_active_cpt       : coverpoint cfg.is_active      ;
      reset_type_cpt      : coverpoint cfg.reset_type     ;
      trn_log_enabled_cpt : coverpoint cfg.trn_log_enabled;
      drv_mode_cpt        : coverpoint cfg.drv_mode       ;
   endgroup : {{ name }}_st_cfg_cg

   /**
    *
    */
   covergroup {{ name }}_st_cntxt_cg;
      {{ tx }}_cntxt_state_cpt : coverpoint cntxt.{{ tx }}_mon_fsm_cntxt.state;
      {{ rx }}_cntxt_state_cpt : coverpoint cntxt.{{ rx }}_mon_fsm_cntxt.state;
   endgroup : {{ name }}_st_cntxt_cg

   /**
    *
    */
   covergroup {{ name }}_st_seq_item_cg;
      header_cpt : coverpoint seq_item.header;
   endgroup : {{ name }}_st_seq_item_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ tx }}_mon_trn_cg;
      header_cpt : coverpoint {{ tx }}_mon_trn.header;
   endgroup : {{ name }}_st_{{ tx }}_mon_trn_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ rx }}_mon_trn_cg;
      header_cpt : coverpoint {{ rx }}_mon_trn.header;
   endgroup : {{ name }}_st_{{ rx }}_mon_trn_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ tx }}_phy_seq_item_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_seq_item_cg
      //      Ex: abc_cpt : coverpoint {{ tx }}_phy_seq_item.abc;
      //          xyz_cpt : coverpoint {{ tx }}_phy_seq_item.xyz;
   endgroup : {{ name }}_st_{{ tx }}_phy_seq_item_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ rx }}_phy_seq_item_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_seq_item_cg
      //      Ex: abc_cpt : coverpoint {{ rx }}_phy_seq_item.abc;
      //          xyz_cpt : coverpoint {{ rx }}_phy_seq_item.xyz;
   endgroup : {{ name }}_st_{{ rx }}_phy_seq_item_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ tx }}_phy_mon_trn_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_mon_trn_cg
      //      Ex: abc_cpt : coverpoint {{ tx }}_phy_mon_trn.abc;
      //          xyz_cpt : coverpoint {{ tx }}_phy_mon_trn.xyz;
   endgroup : {{ name }}_st_{{ tx }}_phy_mon_trn_cg

   /**
    *
    */
   covergroup {{ name }}_st_{{ rx }}_phy_mon_trn_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_mon_trn_cg
      //      Ex: abc_cpt : coverpoint {{ rx }}_phy_mon_trn.abc;
      //          xyz_cpt : coverpoint {{ rx }}_phy_mon_trn.xyz;
   endgroup : {{ name }}_st_{{ rx }}_phy_mon_trn_cg


   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_cov_model", uvm_component parent=null);

   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::end_of_elaboration_phase()
    */
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);

   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();

   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ tx }}_mon_trn()
    */
   extern virtual function void sample_{{ tx }}_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ rx }}_mon_trn()
    */
   extern virtual function void sample_{{ rx }}_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_seq_item()
    */
   extern virtual function void sample_{{ tx }}_phy_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_seq_item()
    */
   extern virtual function void sample_{{ rx }}_phy_seq_item();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_mon_trn()
    */
   extern virtual function void sample_{{ tx }}_phy_mon_trn();

   /**
    * TODO Describe uvma_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_mon_trn()
    */
   extern virtual function void sample_{{ rx }}_phy_mon_trn();

endclass : uvme_{{ name }}_st_cov_model_c


function uvme_{{ name }}_st_cov_model_c::new(string name="uvme_{{ name }}_st_cov_model", uvm_component parent=null);

   super.new(name, parent);
   {{ name }}_st_cfg_cg      = new();
   {{ name }}_st_cntxt_cg    = new();
   {{ name }}_st_seq_item_cg = new();
   {{ name }}_st_{{ tx }}_mon_trn_cg      = new();
   {{ name }}_st_{{ rx }}_mon_trn_cg      = new();
   {{ name }}_st_{{ tx }}_phy_seq_item_cg = new();
   {{ name }}_st_{{ rx }}_phy_seq_item_cg = new();
   {{ name }}_st_{{ tx }}_phy_mon_trn_cg  = new();
   {{ name }}_st_{{ rx }}_phy_mon_trn_cg  = new();

endfunction : new


function void uvme_{{ name }}_st_cov_model_c::end_of_elaboration_phase(uvm_phase phase);

   super.end_of_elaboration_phase(phase);
   sample_cfg();

endfunction : end_of_elaboration_phase


function void uvme_{{ name }}_st_cov_model_c::sample_cfg();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling Configuration:\n%s", cfg.sprint()), UVM_DEBUG)
  {{ name }}_st_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_{{ name }}_st_cov_model_c::sample_cntxt();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling Context:\n%s", cntxt.sprint()), UVM_DEBUG)
   {{ name }}_st_cntxt_cg.sample();

endfunction : sample_cntxt


function void uvme_{{ name }}_st_cov_model_c::sample_seq_item();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling Sequence Item:\n%s", seq_item.sprint()), UVM_DEBUG)
   {{ name }}_st_seq_item_cg.sample();

endfunction : sample_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_mon_trn();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ tx.upper() }} Monitor Transaction:\n%s", {{ tx }}_mon_trn.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ tx }}_mon_trn_cg.sample();

endfunction : sample_{{ tx }}_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_mon_trn();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ rx.upper() }} Monitor Transaction:\n%s", {{ rx }}_mon_trn.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ rx }}_mon_trn_cg.sample();

endfunction : sample_{{ rx }}_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_seq_item();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ tx.upper() }} Phy Sequence Item:\n%s", {{ tx }}_phy_seq_item.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ tx }}_phy_seq_item_cg.sample();

endfunction : sample_{{ tx }}_phy_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_seq_item();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ rx.upper() }} Phy Sequence Item:\n%s", {{ rx }}_phy_seq_item.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ rx }}_phy_seq_item_cg.sample();

endfunction : sample_{{ rx }}_phy_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_mon_trn();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ tx.upper() }} Phy Monitor Transaction:\n%s", {{ tx }}_phy_mon_trn.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ tx }}_phy_mon_trn_cg.sample();

endfunction : sample_{{ tx }}_phy_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_mon_trn();

   `uvm_info("UVME_{{ name.upper() }}_ST_COV_MODEL", $sformatf("Sampling {{ rx.upper() }} Phy Monitor Transaction:\n%s", {{ rx }}_phy_mon_trn.sprint()), UVM_DEBUG)
   {{ name }}_st_{{ rx }}_phy_mon_trn_cg.sample();

endfunction : sample_{{ rx }}_phy_mon_trn


`endif // __UVME_{{ name.upper() }}_ST_COV_MODEL_SV__

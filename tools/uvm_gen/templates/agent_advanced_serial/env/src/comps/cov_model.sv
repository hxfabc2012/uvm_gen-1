// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__
`define __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__


/**
 * Component encapsulating {{ full_name }} Self-Test Environment functional coverage model.
 */
class uvme_{{ name }}_st_cov_model_c extends uvma_{{ name }}_cov_model_c;


   `uvm_component_utils(uvme_{{ name }}_st_cov_model_c)


   covergroup {{ name }}_st_cfg_cg;
      // TODO Implement {{ name }}_st_cfg_cg
      //      Ex: abc_cpt : coverpoint cfg.abc;
      //          xyz_cpt : coverpoint cfg.xyz;
   endgroup : {{ name }}_st_cfg_cg

   covergroup {{ name }}_st_cntxt_cg;
      // TODO Implement {{ name }}_st_cntxt_cg
      //      Ex: abc_cpt : coverpoint cntxt.abc;
      //          xyz_cpt : coverpoint cntxt.xyz;
   endgroup : {{ name }}_st_cntxt_cg

   covergroup {{ name }}_st_seq_item_cg;
      // TODO Implement {{ name }}_st_seq_item_cg
      //      Ex: abc_cpt : coverpoint seq_item.abc;
      //          xyz_cpt : coverpoint seq_item.xyz;
   endgroup : {{ name }}_st_seq_item_cg

   covergroup {{ name }}_st_{{ tx }}_mon_trn_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_mon_trn_cg
      //      Ex: abc_cpt : coverpoint {{ tx }}_mon_trn.abc;
      //          xyz_cpt : coverpoint {{ tx }}_mon_trn.xyz;
   endgroup : {{ name }}_st_{{ tx }}_mon_trn_cg

   covergroup {{ name }}_st_{{ rx }}_mon_trn_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_mon_trn_cg
      //      Ex: abc_cpt : coverpoint {{ rx }}_mon_trn.abc;
      //          xyz_cpt : coverpoint {{ rx }}_mon_trn.xyz;
   endgroup : {{ name }}_st_{{ rx }}_mon_trn_cg

   covergroup {{ name }}_st_{{ tx }}_phy_seq_item_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_seq_item_cg
      //      Ex: abc_cpt : coverpoint {{ tx }}_phy_seq_item.abc;
      //          xyz_cpt : coverpoint {{ tx }}_phy_seq_item.xyz;
   endgroup : {{ name }}_st_{{ tx }}_phy_seq_item_cg

   covergroup {{ name }}_st_{{ rx }}_phy_seq_item_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_seq_item_cg
      //      Ex: abc_cpt : coverpoint {{ rx }}_phy_seq_item.abc;
      //          xyz_cpt : coverpoint {{ rx }}_phy_seq_item.xyz;
   endgroup : {{ name }}_st_{{ rx }}_phy_seq_item_cg

   covergroup {{ name }}_st_{{ tx }}_phy_mon_trn_cg;
      // TODO Implement {{ name }}_st_{{ tx }}_phy_mon_trn_cg
      //      Ex: abc_cpt : coverpoint {{ tx }}_phy_mon_trn.abc;
      //          xyz_cpt : coverpoint {{ tx }}_phy_mon_trn.xyz;
   endgroup : {{ name }}_st_{{ tx }}_phy_mon_trn_cg

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
   {{ name }}_st_cfg_cg        = new();
   {{ name }}_st_cntxt_cg      = new();
   {{ name }}_st_tx_mon_trn_cg = new();
   {{ name }}_st_rx_mon_trn_cg = new();
   {{ name }}_st_seq_item_cg   = new();

endfunction : new


function void uvme_{{ name }}_st_cov_model_c::sample_cfg();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling Configuration:\n%s", cfg.sprint()), UVM_HIGH)
  {{ name }}_st_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_{{ name }}_st_cov_model_c::sample_cntxt();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling Context:\n%s", cntxt.sprint()), UVM_HIGH)
   {{ name }}_st_cntxt_cg.sample();

endfunction : sample_cntxt


function void uvme_{{ name }}_st_cov_model_c::sample_seq_item();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling Sequence Item:\n%s", seq_item.sprint()), UVM_HIGH)
   {{ name }}_st_seq_item_cg.sample();

endfunction : sample_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_mon_trn();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(tx) }} Monitor Transaction:\n%s", tx_mon_trn.sprint()), UVM_HIGH)
   {{ name }}_st_tx_mon_trn_cg.sample();

endfunction : sample_{{ tx }}_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_mon_trn();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(rx) }} Monitor Transaction:\n%s", {{ rx }}_mon_trn.sprint()), UVM_HIGH)
   {{ name }}_st_{{ rx }}_mon_trn_cg.sample();

endfunction : sample_{{ rx }}_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_seq_item();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(tx) }} Phy Sequence Item:\n%s", {{ tx }}_phy_seq_item.sprint()), UVM_HIGH)
   {{ name }}_st_{{ tx }}_phy_seq_item_cg.sample();

endfunction : sample_{{ tx }}_phy_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_seq_item();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(rx) }} Phy Sequence Item:\n%s", {{ rx }}_phy_seq_item.sprint()), UVM_HIGH)
   {{ name }}_st_{{ rx }}_phy_seq_item_cg.sample();

endfunction : sample_{{ rx }}_phy_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_{{ tx }}_phy_mon_trn();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(tx) }} Phy Monitor Transaction:\n%s", {{ tx }}_phy_mon_trn.sprint()), UVM_HIGH)
   {{ name }}_st_{{ tx }}_phy_mon_trn_cg.sample();

endfunction : sample_{{ tx }}_phy_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_{{ rx }}_phy_mon_trn();

   `uvm_info("UVME_{{ upper(name) }}_ST_COV_MODEL", $sformatf("Sampling {{ upper(rx) }} Phy Monitor Transaction:\n%s", {{ rx }}_phy_mon_trn.sprint()), UVM_HIGH)
   {{ name }}_st_{{ rx }}_phy_mon_trn_cg.sample();

endfunction : sample_{{ rx }}_phy_mon_trn


`endif // __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__

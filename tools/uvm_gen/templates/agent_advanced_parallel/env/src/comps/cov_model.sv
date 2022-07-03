// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__
`define __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__


/**
 * Component encapsulating {{ upper(name) }} Agent Self-Test Environment functional coverage model.
 */
class uvme_{{ name }}_st_cov_model_c extends uvma_{{ name }}_cov_model_c;
   
   `uvm_component_utils(uvme_{{ name }}_st_cov_model_c)
   
   
   covergroup {{ name }}_st_cfg_cg;
      // TODO Implement {{ name }}_st_cfg_cg
   endgroup : {{ name }}_st_cfg_cg
   
   covergroup {{ name }}_st_cntxt_cg;
      // TODO Implement {{ name }}_st_cntxt_cg
   endgroup : {{ name }}_st_cntxt_cg
   
   covergroup {{ name }}_st_mon_trn_cg;
      // TODO Implement {{ name }}_st_mon_trn_cg
   endgroup : {{ name }}_st_mon_trn_cg
   
   covergroup {{ name }}_st_mstr_a_mon_trn_cg;
      // TODO Implement {{ name }}_st_mstr_a_mon_trn_cg
   endgroup : {{ name }}_st_mstr_a_mon_trn_cg
   
   covergroup {{ name }}_st_mstr_r_mon_trn_cg;
      // TODO Implement {{ name }}_st_mstr_r_mon_trn_cg
   endgroup : {{ name }}_st_mstr_r_mon_trn_cg
   
   covergroup {{ name }}_st_slv_a_mon_trn_cg;
      // TODO Implement {{ name }}_st_slv_a_mon_trn_cg
   endgroup : {{ name }}_st_slv_a_mon_trn_cg
   
   covergroup {{ name }}_st_slv_r_mon_trn_cg;
      // TODO Implement {{ name }}_st_slv_r_mon_trn_cg
   endgroup : {{ name }}_st_slv_r_mon_trn_cg
   
   covergroup {{ name }}_st_seq_item_cg;
      // TODO Implement {{ name }}_st_seq_item_cg
   endgroup : {{ name }}_st_seq_item_cg
   
   covergroup {{ name }}_st_mstr_a_seq_item_cg;
      // TODO Implement {{ name }}_st_mstr_a_seq_item_cg
   endgroup : {{ name }}_st_mstr_a_seq_item_cg
   
   covergroup {{ name }}_st_mstr_r_seq_item_cg;
      // TODO Implement {{ name }}_st_mstr_r_seq_item_cg
   endgroup : {{ name }}_st_mstr_r_seq_item_cg
   
   covergroup {{ name }}_st_slv_a_seq_item_cg;
      // TODO Implement {{ name }}_st_slv_a_seq_item_cg
   endgroup : {{ name }}_st_slv_a_seq_item_cg
   
   covergroup {{ name }}_st_slv_r_seq_item_cg;
      // TODO Implement {{ name }}_st_slv_r_seq_item_cg
   endgroup : {{ name }}_st_slv_r_seq_item_cg
   
   
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
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_mon_trn()
    */
   extern virtual function void sample_mon_trn();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_mstr_mon_a_trn()
    */
   extern virtual function void sample_mstr_a_mon_trn();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_mstr_mon_r_trn()
    */
   extern virtual function void sample_mstr_r_mon_trn();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_slv_a_mon_trn()
    */
   extern virtual function void sample_slv_a_mon_trn();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_slv_r_mon_trn()
    */
   extern virtual function void sample_slv_r_mon_trn();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_mstr_a_seq_item()
    */
   extern virtual function void sample_mstr_a_seq_item();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_mstr_r_seq_item()
    */
   extern virtual function void sample_mstr_r_seq_item();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_slv_a_seq_item()
    */
   extern virtual function void sample_slv_a_seq_item();
   
   /**
    * TODO Describe uvme_{{ name }}_st_cov_model_c::sample_slv_r_seq_item()
    */
   extern virtual function void sample_slv_r_seq_item();
   
endclass : uvme_{{ name }}_st_cov_model_c


function uvme_{{ name }}_st_cov_model_c::new(string name="uvme_{{ name }}_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
   {{ name }}_st_cfg_cg             = new();
   {{ name }}_st_cntxt_cg           = new();
   {{ name }}_st_mon_trn_cg         = new();
   {{ name }}_st_mstr_a_mon_trn_cg  = new();
   {{ name }}_st_mstr_r_mon_trn_cg  = new();
   {{ name }}_st_slv_a_mon_trn_cg   = new();
   {{ name }}_st_slv_r_mon_trn_cg   = new();
   {{ name }}_st_seq_item_cg        = new();
   {{ name }}_st_mstr_a_seq_item_cg = new();
   {{ name }}_st_mstr_r_seq_item_cg = new();
   {{ name }}_st_slv_a_seq_item_cg  = new();
   {{ name }}_st_slv_r_seq_item_cg  = new();
   
endfunction : new


function void uvme_{{ name }}_st_cov_model_c::sample_cfg();
   
   {{ name }}_st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_{{ name }}_st_cov_model_c::sample_cntxt();
   
   {{ name }}_st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_{{ name }}_st_cov_model_c::sample_mon_trn();
   
   {{ name }}_st_mon_trn_cg.sample();
   
endfunction : sample_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_mstr_a_mon_trn();
   
   {{ name }}_st_mstr_a_mon_trn_cg.sample();
   
endfunction : sample_mstr_a_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_mstr_r_mon_trn();
   
   {{ name }}_st_mstr_r_mon_trn_cg.sample();
   
endfunction : sample_mstr_r_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_slv_a_mon_trn();
   
   {{ name }}_st_slv_a_mon_trn_cg.sample();
   
endfunction : sample_slv_a_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_slv_r_mon_trn();
   
   {{ name }}_st_slv_r_mon_trn_cg.sample();
   
endfunction : sample_slv_r_mon_trn


function void uvme_{{ name }}_st_cov_model_c::sample_seq_item();
   
   {{ name }}_st_seq_item_cg.sample();
   
endfunction : sample_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_mstr_a_seq_item();
   
   {{ name }}_st_mstr_a_seq_item_cg.sample();
   
endfunction : sample_mstr_a_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_mstr_r_seq_item();
   
   {{ name }}_st_mstr_r_seq_item_cg.sample();
   
endfunction : sample_mstr_r_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_slv_a_seq_item();
   
   {{ name }}_st_slv_a_seq_item_cg.sample();
   
endfunction : sample_slv_a_seq_item


function void uvme_{{ name }}_st_cov_model_c::sample_slv_r_seq_item();
   
   {{ name }}_st_slv_r_seq_item_cg.sample();
   
endfunction : sample_slv_r_seq_item


`endif // __UVME_{{ upper(name) }}_ST_COV_MODEL_SV__

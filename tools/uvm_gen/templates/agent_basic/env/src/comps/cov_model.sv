// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_ST_COV_MODEL_SV__
`define __UVME_${name_uppercase}_ST_COV_MODEL_SV__


/**
 * Component encapsulating ${name_normal_case} UVM Agent Self-Test functional coverage model.
 */
class uvme_${name}_st_cov_model_c extends uvma_${name}_cov_model_c;

   `uvm_component_utils(uvme_${name}_st_cov_model_c)


   /**
    * Agent configuration functional coverage.
    */
   covergroup ${name}_st_cfg_cg;
      enabled_cpt   : coverpoint cfg.enabled  ;
      is_active_cpt : coverpoint cfg.is_active;
   endgroup : ${name}_st_cfg_cg

   /**
    * Agent context functional coverage.
    */
   covergroup ${name}_st_cntxt_cg;
      reset_state_cpt : coverpoint cntxt.reset_state;
   endgroup : ${name}_st_cntxt_cg

   /**
    * Agent sequence item functional coverage.
    */
   covergroup ${name}_st_seq_item_cg;
      // TODO Implement ${name}_st_seq_item_cg
      //      Ex: abc_cpt : coverpoint seq_item.abc;
      //          xyz_cpt : coverpoint seq_item.xyz;
   endgroup : ${name}_st_seq_item_cg

   /**
    * Agent monitored transactions functional coverage.
    */
   covergroup ${name}_st_mon_trn_cg;
      // TODO Implement ${name}_st_mon_trn_cg
      //      Ex: abc_cpt : coverpoint mon_trn.abc;
      //          xyz_cpt : coverpoint mon_trn.xyz;
   endgroup : ${name}_st_mon_trn_cg


   /**
    * Creates all covergroups.
    */
   extern function new(string name="uvme_${name}_st_cov_model", uvm_component parent=null);

   /**
    * Samples #${name}_st_cfg_cg
    */
   extern virtual function void sample_cfg();

   /**
    * Samples #${name}_st_cntxt_cg
    */
   extern virtual function void sample_cntxt();

   /**
    * Samples ${name}_st_seq_item_cg
    */
   extern virtual function void sample_${name}_seq_item();

   /**
    * Samples ${name}_st_mon_trn_cg
    */
   extern virtual function void sample_${name}_mon_trn();

endclass : uvme_${name}_st_cov_model_c


function uvme_${name}_st_cov_model_c::new(string name="uvme_${name}_st_cov_model", uvm_component parent=null);

   super.new(name, parent);
   ${name}_st_cfg_cg      = new();
   ${name}_st_cntxt_cg    = new();
   ${name}_st_seq_item_cg = new();
   ${name}_st_mon_trn_cg  = new();

endfunction : new


function void uvme_${name}_st_cov_model_c::sample_cfg();

  ${name}_st_cfg_cg.sample();

endfunction : sample_cfg


function void uvme_${name}_st_cov_model_c::sample_cntxt();

   ${name}_st_cntxt_cg.sample();

endfunction : sample_cntxt


function void uvme_${name}_st_cov_model_c::sample_${name}_seq_item();

   ${name}_st_seq_item_cg.sample();

endfunction : sample_${name}_seq_item


function void uvme_${name}_st_cov_model_c::sample_${name}_mon_trn();

   ${name}_st_mon_trn_cg.sample();

endfunction : sample_${name}_mon_trn


`endif // __UVME_${name_uppercase}_ST_COV_MODEL_SV__

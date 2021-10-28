// Copyright 2021 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_DP_COV_MODEL_SV__
`define __UVME_DP_COV_MODEL_SV__


/**
 * Component encapsulating Data Plane environment's functional coverage model.
 */
class uvme_dp_cov_model_c extends uvm_component;
   
   // Objects
   uvme_dp_cfg_c    cfg;
   uvme_dp_cntxt_c  cntxt;
   // TODO Add covergoup sampling variable(s)
   //      Ex: uvma_axil_mon_trn_c  axil_trn;
   
   // Input TLM
   // TODO Add Input TLM to uvme_dp_cov_model_c
   //      Ex: uvm_analysis_port    #(uvma_axil_mon_trn_c)  axil_export;
   //          uvm_tlm_analysis_fifo#(uvma_axil_mon_trn_c)  axil_fifo;
   
   
   `uvm_component_utils_begin(uvme_dp_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   // TODO Add covergroup(s) to uvme_dp_cov_model_c
   //      Ex: covergroup dp_cfg_cg;
   //             abc_cpt : coverpoint cfg.abc;
   //             xyz_cpt : coverpoint cfg.xyz;
   //          endgroup : dp_cfg_cg
   //          
   //          covergroup dp_cntxt_cg;
   //             abc_cpt : coverpoint cntxt.abc;
   //             xyz_cpt : coverpoint cntxt.xyz;
   //          endgroup : dp_cntxt_cg
   //          
   //          covergroup axil_trn_cg;
   //             address : coverpoint axil_trn.address {
   //                bins low   = {32'h0000_0000, 32'h4FFF_FFFF};
   //                bins med   = {32'h5000_0000, 32'h9FFF_FFFF};
   //                bins high  = {32'hA000_0000, 32'hFFFF_FFFF};
   //             }
   //          endgroup : axil_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dp_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Describe uvme_dp_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_dp_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_dp_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   // TODO Add coverage functions to uvme_dp_cov_model_c
   //      Ex: /**
   //           * Samples trn via axil_cg
   //           */
   //          extern function void sample_axil();
   
endclass : uvme_dp_cov_model_c


function uvme_dp_cov_model_c::new(string name="uvme_dp_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
   // TODO Create coverage groups for uvme_dp_cov_model_c
   //      Ex: axil_cg = new();
   
endfunction : new


function void uvme_dp_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_dp_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_dp_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // TODO Build Input TLM
   //      Ex: axil_export = new("axil_export", this);
   //          axil_fifo   = new("axil_fifo"  , this);
   
endfunction : build_phase


task uvme_dp_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      // Configuration
      forever begin
         cntxt.sample_cfg_e.wait_trigger();
         sample_cfg();
      end
      
      // Context
      forever begin
         cntxt.sample_cntxt_e.wait_trigger();
         sample_cntxt();
      end
      
      // TODO Implement uvme_dp_cov_model_c::run_phase()
      //      Ex: forever begin
      //             axil_fifo.get(axil_trn);
      //             sample_axil();
      //          end
   join_none
   
endtask : run_phase


function void uvme_dp_cov_model_c::sample_cfg();
   
   // TODO Implement uvme_dp_cov_model_c::sample_cfg();
   //      Ex: dp_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_dp_cov_model_c::sample_cntxt();
   
   // TODO Implement uvme_dp_cov_model_c::sample_cntxt();
   //      Ex: dp_cntxt_cg.sample();
   
endfunction : sample_cntxt


// TODO Implement coverage function(s) to uvme_dp_cov_model_c
//      Ex: function void uvme_dp_cov_model_c::sample_axil();
//             
//             axil_trn_cg.sample();
//             
//          endfunction : sample_axil


`endif // __UVME_DP_COV_MODEL_SV__

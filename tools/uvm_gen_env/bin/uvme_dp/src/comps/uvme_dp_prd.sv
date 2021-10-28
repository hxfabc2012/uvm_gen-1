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


`ifndef __UVME_DP_PRD_SV__
`define __UVME_DP_PRD_SV__


/**
 * Component implementing transaction-based software model of Data Plane DUT.
 */
class uvme_dp_prd_c extends uvm_component;
   
   // Objects
   uvme_dp_cfg_c    cfg;
   uvme_dp_cntxt_c  cntxt;
   
   // Input TLM
   uvm_analysis_export  #(uvma_clk_mon_trn_c)  sys_clk_export;
   uvm_tlm_analysis_fifo#(uvma_clk_mon_trn_c)  sys_clk_fifo;
   uvm_analysis_export  #(uvma_reset_mon_trn_c)  sys_reset_export;
   uvm_tlm_analysis_fifo#(uvma_reset_mon_trn_c)  sys_reset_fifo;
   uvm_analysis_export  #(uvma_axil_mon_trn_c)  axil_export;
   uvm_tlm_analysis_fifo#(uvma_axil_mon_trn_c)  axil_fifo;
   
   // Output TLM
   // TODO Add TLM outputs to uvme_dp_prd_c
   //      Ex: uvm_analysis_port#(uvma_packet_trn_c)  pkts_out_ap;
   
   
   `uvm_component_utils_begin(uvme_dp_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_dp_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_dp_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_dp_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_dp_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_dp_prd_c::process_sys_clk()
    */
   extern task process_sys_clk();
   
   /**
    * TODO Describe uvme_dp_prd_c::process_sys_reset()
    */
   extern task process_sys_reset();
   
   /**
    * TODO Describe uvme_dp_prd_c::process_axil()
    */
   extern task process_axil();
   
endclass : uvme_dp_prd_c


function uvme_dp_prd_c::new(string name="uvme_dp_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_dp_prd_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_dp_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_dp_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build Input TLM objects
   sys_clk_export = new("sys_clk_export", this);
   sys_clk_fifo   = new("sys_clk_fifo"  , this);
   sys_reset_export = new("sys_reset_export", this);
   sys_reset_fifo   = new("sys_reset_fifo"  , this);
   axil_export = new("axil_export", this);
   axil_fifo   = new("axil_fifo"  , this);
   
   // Build Output TLM objects
   // TODO Create Output TLM objects for uvme_dp_prd_c
   //      Ex: pkts_out_ap = new("pkts_out_ap", this);
   
endfunction : build_phase


function void uvme_dp_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   sys_clk_export.connect(sys_clk_fifo.analysis_export);
   sys_reset_export.connect(sys_reset_fifo.analysis_export);
   axil_export.connect(axil_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_dp_prd_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   fork
      process_sys_clk();
      process_sys_reset();
      process_axil();
   join_none
   
endtask: run_phase


task uvme_dp_prd_c::process_sys_clk();
   
   uvma_clk_mon_trn_c  sys_clk_trn;
   
   forever begin
      sys_clk_fifo.get(sys_clk_trn);
      
      // TODO Implement uvme_dp_prd_c::process_sys_clk()
   end
   
endtask : process_sys_clk


task uvme_dp_prd_c::process_sys_reset();
   
   uvma_reset_mon_trn_c  sys_reset_trn;
   
   forever begin
      sys_reset_fifo.get(sys_reset_trn);
      
      // TODO Implement uvme_dp_prd_c::process_sys_reset()
   end
   
endtask : process_sys_reset


task uvme_dp_prd_c::process_axil();
   
   uvma_axil_mon_trn_c  axil_trn;
   
   forever begin
      axil_fifo.get(axil_trn);
      
      // TODO Implement uvme_dp_prd_c::process_axil()
   end
   
endtask : process_axil


`endif // __UVME_DP_PRD_SV__

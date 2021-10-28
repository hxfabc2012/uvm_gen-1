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


`ifndef __UVME_DP_PKG_SV__
`define __UVME_DP_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.sv"
`include "uvml_sb_macros.sv"
`include "uvml_ral_macros.sv"
`include "uvma_clk_macros.sv"
`include "uvma_reset_macros.sv"
`include "uvma_axil_macros.sv"
`include "uvme_dp_macros.sv"

// Interface(s)


 /**
 * Encapsulates all the types needed for an UVM environment capable of driving/monitoring and verifying the behavior of
 * a Data Plane design.
 */
package uvme_dp_pkg;
   
   import uvm_pkg       ::*;
   import uvml_pkg      ::*;
   import uvml_sb_pkg   ::*;
   import uvml_ral_pkg  ::*;
   import uvma_clk_pkg::*;
   import uvma_reset_pkg::*;
   import uvma_axil_pkg::*;
   
   // Constants / Structs / Enums
   `include "uvme_dp_tdefs.sv"
   `include "uvme_dp_constants.sv"
   
   // Register Abstraction Layer
   `include "uvme_dp_reg_block.sv"
   
   // Objects
   `include "uvme_dp_cfg.sv"
   `include "uvme_dp_cntxt.sv"
   
   // Predictor
   `include "uvme_dp_prd.sv"
   
   // Environment components
   `include "uvme_dp_cov_model.sv"
   `include "uvme_dp_sb.sv"
   `include "uvme_dp_vsqr.sv"
   `include "uvme_dp_env.sv"
   
   // Sequences
   `include "uvme_dp_vseq_lib.sv"
   
endpackage : uvme_dp_pkg


// Module(s) / Checker(s)
`ifdef UVME_DP_INC_CHKR
`include "uvma_dp_chkr.sv"
`endif


`endif // __UVME_DP_PKG_SV__

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


`ifndef __UVMT_DP_DUT_WRAP_SV__
`define __UVMT_DP_DUT_WRAP_SV__


/**
 * Module wrapper for Data Plane RTL DUT.  All ports are SV interfaces.
 */
module uvmt_dp_dut_wrap(
   uvma_axil_if  axil_if,
   uvmt_dp_probe_if  probe_if
);
   
   // \/ CODE BELOW IS RESPONSABILITY OF DESIGNERS \/
   
   // TODO Instantiate Device Under Test (DUT) and connect it to the interfaces signals
   //      Ex: dp_top  dut(
   //             .clk    (axil_if.clk),
   //             .reset_n(axil_if.reset_n),
   //             .axil_data(axil_if.data),
   //             ...
   //          );
   
   // TODO Connect probe interface signals to design
   //      Ex: assign probe_if.abc = dut.abc;
   
   // /\ CODE ABOVE IS RESPONSABILITY OF DESIGNERS /\
   
endmodule : uvmt_dp_dut_wrap


`endif // __UVMT_DP_DUT_WRAP_SV__

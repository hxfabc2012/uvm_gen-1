// Copyright ${year} ${name_of_copyright_owner}
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_${name_uppercase}_ST_TDEFS_SV__
`define __UVME_${name_uppercase}_ST_TDEFS_SV__


// Scoreboard specialization
typedef uvml_sb_simplex_c#(
   .T_TRN(uvma_${name}_mon_trn_c)
) uvme_${name}_st_sb_simplex_c;


`endif // __UVME_${name_uppercase}_ST_TDEFS_SV__

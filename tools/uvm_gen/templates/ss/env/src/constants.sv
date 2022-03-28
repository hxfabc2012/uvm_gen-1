// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_CONSTANTS_SV__
`define __UVME_${name_uppercase}_CONSTANTS_SV__


const int unsigned      uvme_${name}_default_${clk_agent_name}_period = 10_000; // 10ns
const longint unsigned  uvme_${name}_default_reg_block_base_address = 64'h0000_0000_0000_0000;
const int unsigned      uvme_${name}_reg_block_reg_n_bytes  = 4; // bytes (B)


`endif // __UVME_${name_uppercase}_CONSTANTS_SV__

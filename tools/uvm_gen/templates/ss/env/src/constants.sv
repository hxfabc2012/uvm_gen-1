// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_CONSTANTS_SV__
`define __UVME_${name_uppercase}_CONSTANTS_SV__


const int unsigned      uvme_${name}_default_${clk_agent_name}_period = 10_000; ///< Clock agent period (in ps)
const longint unsigned  uvme_${name}_default_reg_block_base_address   = 64'h0000_0000_0000_0000; ///< Register block base address
const int unsigned      uvme_${name}_reg_block_reg_n_bytes            = 4; ///< Width of registers in bytes (B)


`endif // __UVME_${name_uppercase}_CONSTANTS_SV__

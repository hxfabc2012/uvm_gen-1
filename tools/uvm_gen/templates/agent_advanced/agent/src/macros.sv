// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_${name_uppercase}_MACROS_SV__
`define __UVMA_${name_uppercase}_MACROS_SV__


`ifndef UVMA_${name_uppercase}_ADDR_MAX_WIDTH
`define UVMA_${name_uppercase}_ADDR_MAX_WIDTH       32
`endif
`ifndef UVMA_${name_uppercase}_DATA_MAX_WIDTH
`define UVMA_${name_uppercase}_DATA_MAX_WIDTH       32
`endif
`ifndef UVMA_${name_uppercase}_AUSER_MAX_WIDTH
`define UVMA_${name_uppercase}_AUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_${name_uppercase}_WUSER_MAX_WIDTH
`define UVMA_${name_uppercase}_WUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_${name_uppercase}_RUSER_MAX_WIDTH
`define UVMA_${name_uppercase}_RUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_${name_uppercase}_ID_MAX_WIDTH
`define UVMA_${name_uppercase}_ID_MAX_WIDTH         32
`endif
`ifndef UVMA_${name_uppercase}_ACHK_MAX_WIDTH
`define UVMA_${name_uppercase}_ACHK_MAX_WIDTH       32
`endif
`ifndef UVMA_${name_uppercase}_RCHK_MAX_WIDTH
`define UVMA_${name_uppercase}_RCHK_MAX_WIDTH       32
`endif

`ifndef UVMA_${name_uppercase}_ADDR_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_ADDR_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_${name_uppercase}_DATA_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_DATA_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_${name_uppercase}_AUSER_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_AUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_${name_uppercase}_WUSER_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_WUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_${name_uppercase}_RUSER_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_RUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_${name_uppercase}_ID_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_ID_DEFAULT_WIDTH      0
`endif
`ifndef UVMA_${name_uppercase}_ACHK_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_ACHK_DEFAULT_WIDTH    0
`endif
`ifndef UVMA_${name_uppercase}_RCHK_DEFAULT_WIDTH
`define UVMA_${name_uppercase}_RCHK_DEFAULT_WIDTH    0
`endif

`ifndef UVMA_${name_uppercase}_MSTR_DRV_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_MSTR_DRV_SEQ_ITEM_PRI    100
`endif
`ifndef UVMA_${name_uppercase}_SLV_DRV_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_SLV_DRV_SEQ_ITEM_PRI     100
`endif
`ifndef UVMA_${name_uppercase}_MSTR_A_IDLE_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_MSTR_A_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_${name_uppercase}_MSTR_R_IDLE_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_MSTR_R_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_${name_uppercase}_SLV_A_IDLE_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_SLV_A_IDLE_SEQ_ITEM_PRI    1
`endif
`ifndef UVMA_${name_uppercase}_SLV_R_IDLE_SEQ_ITEM_PRI
`define UVMA_${name_uppercase}_SLV_R_IDLE_SEQ_ITEM_PRI    1
`endif

`endif // __UVMA_${name_uppercase}_MACROS_SV__

// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_OBI_MACROS_SV__
`define __UVMA_OBI_MACROS_SV__


`ifndef UVMA_OBI_ADDR_MAX_WIDTH
`define UVMA_OBI_ADDR_MAX_WIDTH       32
`endif
`ifndef UVMA_OBI_DATA_MAX_WIDTH
`define UVMA_OBI_DATA_MAX_WIDTH       32
`endif
`ifndef UVMA_OBI_AUSER_MAX_WIDTH
`define UVMA_OBI_AUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_OBI_WUSER_MAX_WIDTH
`define UVMA_OBI_WUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_OBI_RUSER_MAX_WIDTH
`define UVMA_OBI_RUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_OBI_ID_MAX_WIDTH
`define UVMA_OBI_ID_MAX_WIDTH         32
`endif
`ifndef UVMA_OBI_ACHK_MAX_WIDTH
`define UVMA_OBI_ACHK_MAX_WIDTH       32
`endif
`ifndef UVMA_OBI_RCHK_MAX_WIDTH
`define UVMA_OBI_RCHK_MAX_WIDTH       32
`endif

`ifndef UVMA_OBI_ADDR_DEFAULT_WIDTH
`define UVMA_OBI_ADDR_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_OBI_DATA_DEFAULT_WIDTH
`define UVMA_OBI_DATA_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_OBI_AUSER_DEFAULT_WIDTH
`define UVMA_OBI_AUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_OBI_WUSER_DEFAULT_WIDTH
`define UVMA_OBI_WUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_OBI_RUSER_DEFAULT_WIDTH
`define UVMA_OBI_RUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_OBI_ID_DEFAULT_WIDTH
`define UVMA_OBI_ID_DEFAULT_WIDTH      0
`endif
`ifndef UVMA_OBI_ACHK_DEFAULT_WIDTH
`define UVMA_OBI_ACHK_DEFAULT_WIDTH    0
`endif
`ifndef UVMA_OBI_RCHK_DEFAULT_WIDTH
`define UVMA_OBI_RCHK_DEFAULT_WIDTH    0
`endif

`ifndef UVMA_OBI_MSTR_DRV_SEQ_ITEM_PRI
`define UVMA_OBI_MSTR_DRV_SEQ_ITEM_PRI    100
`endif
`ifndef UVMA_OBI_SLV_DRV_SEQ_ITEM_PRI
`define UVMA_OBI_SLV_DRV_SEQ_ITEM_PRI     100
`endif
`ifndef UVMA_OBI_MSTR_A_IDLE_SEQ_ITEM_PRI
`define UVMA_OBI_MSTR_A_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_OBI_MSTR_R_IDLE_SEQ_ITEM_PRI
`define UVMA_OBI_MSTR_R_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_OBI_SLV_A_IDLE_SEQ_ITEM_PRI
`define UVMA_OBI_SLV_A_IDLE_SEQ_ITEM_PRI    1
`endif
`ifndef UVMA_OBI_SLV_R_IDLE_SEQ_ITEM_PRI
`define UVMA_OBI_SLV_R_IDLE_SEQ_ITEM_PRI    1
`endif

`endif // __UVMA_OBI_MACROS_SV__

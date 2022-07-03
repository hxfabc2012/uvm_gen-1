// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_MACROS_SV__
`define __UVMA_{{ upper(name) }}_MACROS_SV__


`ifndef UVMA_{{ upper(name) }}_ADDR_MAX_WIDTH
`define UVMA_{{ upper(name) }}_ADDR_MAX_WIDTH       32
`endif
`ifndef UVMA_{{ upper(name) }}_DATA_MAX_WIDTH
`define UVMA_{{ upper(name) }}_DATA_MAX_WIDTH       32
`endif
`ifndef UVMA_{{ upper(name) }}_AUSER_MAX_WIDTH
`define UVMA_{{ upper(name) }}_AUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_{{ upper(name) }}_WUSER_MAX_WIDTH
`define UVMA_{{ upper(name) }}_WUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_{{ upper(name) }}_RUSER_MAX_WIDTH
`define UVMA_{{ upper(name) }}_RUSER_MAX_WIDTH      32
`endif
`ifndef UVMA_{{ upper(name) }}_ID_MAX_WIDTH
`define UVMA_{{ upper(name) }}_ID_MAX_WIDTH         32
`endif
`ifndef UVMA_{{ upper(name) }}_ACHK_MAX_WIDTH
`define UVMA_{{ upper(name) }}_ACHK_MAX_WIDTH       32
`endif
`ifndef UVMA_{{ upper(name) }}_RCHK_MAX_WIDTH
`define UVMA_{{ upper(name) }}_RCHK_MAX_WIDTH       32
`endif

`ifndef UVMA_{{ upper(name) }}_ADDR_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_ADDR_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_{{ upper(name) }}_DATA_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_DATA_DEFAULT_WIDTH   32
`endif
`ifndef UVMA_{{ upper(name) }}_AUSER_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_AUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_{{ upper(name) }}_WUSER_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_WUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_{{ upper(name) }}_RUSER_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_RUSER_DEFAULT_WIDTH   0
`endif
`ifndef UVMA_{{ upper(name) }}_ID_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_ID_DEFAULT_WIDTH      0
`endif
`ifndef UVMA_{{ upper(name) }}_ACHK_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_ACHK_DEFAULT_WIDTH    0
`endif
`ifndef UVMA_{{ upper(name) }}_RCHK_DEFAULT_WIDTH
`define UVMA_{{ upper(name) }}_RCHK_DEFAULT_WIDTH    0
`endif

`ifndef UVMA_{{ upper(name) }}_MSTR_DRV_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_MSTR_DRV_SEQ_ITEM_PRI    100
`endif
`ifndef UVMA_{{ upper(name) }}_SLV_DRV_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_SLV_DRV_SEQ_ITEM_PRI     100
`endif
`ifndef UVMA_{{ upper(name) }}_MSTR_A_IDLE_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_MSTR_A_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_{{ upper(name) }}_MSTR_R_IDLE_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_MSTR_R_IDLE_SEQ_ITEM_PRI   1
`endif
`ifndef UVMA_{{ upper(name) }}_SLV_A_IDLE_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_SLV_A_IDLE_SEQ_ITEM_PRI    1
`endif
`ifndef UVMA_{{ upper(name) }}_SLV_R_IDLE_SEQ_ITEM_PRI
`define UVMA_{{ upper(name) }}_SLV_R_IDLE_SEQ_ITEM_PRI    1
`endif

`endif // __UVMA_{{ upper(name) }}_MACROS_SV__

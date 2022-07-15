// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_TDEFS_SV__
`define __UVMA_{{ upper(name) }}_TDEFS_SV__


typedef bit   [31:0]  uvma_{{ name }}_data_b_t;
typedef logic [31:0]  uvma_{{ name }}_data_l_t;
typedef bit   [ 1:0]  uvma_{{ name }}_tail_b_t;
typedef logic [ 1:0]  uvma_{{ name }}_tail_l_t;

typedef enum {
   UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_1) }},
   UVMA_{{ upper(name) }}_DRV_MODE_{{ upper(mode_2) }}
} uvma_{{ name }}_mode_enum;

typedef enum {
   UVMA_{{ upper(name) }}_DIRECTION_{{ upper(tx) }},
   UVMA_{{ upper(name) }}_DIRECTION_{{ upper(rx) }}
} uvma_{{ name }}_direction_enum;

typedef enum {
   UVMA_{{ upper(name) }}_MON_FSM_INIT    ,
   UVMA_{{ upper(name) }}_MON_FSM_TRAINING,
   UVMA_{{ upper(name) }}_MON_FSM_SYNCING ,
   UVMA_{{ upper(name) }}_MON_FSM_SYNCED
} uvma_{{ name }}_mon_fsm_enum;

typedef enum bit [1:0] {
   UVMA_{{ upper(name) }}_HEADER_DATA = 2'b01,
   UVMA_{{ upper(name) }}_HEADER_IDLE = 2'b10
} uvma_{{ name }}_header_enum;


`endif // __UVMA_{{ upper(name) }}_TDEFS_SV__

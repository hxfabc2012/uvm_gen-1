// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_TDEFS_SV__
`define __UVMA_{{ name.upper() }}_TDEFS_SV__


typedef bit   [ 1:0]  uvma_{{ name }}_header_b_t; ///<
typedef logic [ 1:0]  uvma_{{ name }}_header_l_t; ///<
typedef bit   [31:0]  uvma_{{ name }}_data_b_t  ; ///<
typedef logic [31:0]  uvma_{{ name }}_data_l_t  ; ///<
typedef bit   [ 1:0]  uvma_{{ name }}_tail_b_t  ; ///<
typedef logic [ 1:0]  uvma_{{ name }}_tail_l_t  ; ///<

/**
 *
 */
typedef enum {
   UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}, ///<
   UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}  ///<
} uvma_{{ name }}_mode_enum;

/**
 *
 */
typedef enum {
   UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }}, ///<
   UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }}  ///<
} uvma_{{ name }}_direction_enum;

/**
 *
 */
typedef enum {
   UVMA_{{ name.upper() }}_MON_FSM_INIT    , ///<
   UVMA_{{ name.upper() }}_MON_FSM_TRAINING, ///<
   UVMA_{{ name.upper() }}_MON_FSM_SYNCING , ///<
   UVMA_{{ name.upper() }}_MON_FSM_SYNCED    ///<
} uvma_{{ name }}_mon_fsm_enum;

/**
 *
 */
typedef enum bit [1:0] {
   UVMA_{{ name.upper() }}_HEADER_IDLE = 2'b01, ///<
   UVMA_{{ name.upper() }}_HEADER_DATA = 2'b10  ///<
} uvma_{{ name }}_header_enum;


`endif // __UVMA_{{ name.upper() }}_TDEFS_SV__

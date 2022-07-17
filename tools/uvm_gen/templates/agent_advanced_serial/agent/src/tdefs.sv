// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ name.upper() }}_TDEFS_SV__
`define __UVMA_{{ name.upper() }}_TDEFS_SV__


typedef bit   [ 1:0]  uvma_{{ name }}_header_b_t; ///< Vector representing header data in bit type
typedef logic [ 1:0]  uvma_{{ name }}_header_l_t; ///< Vector representing header data in logic type
typedef bit   [31:0]  uvma_{{ name }}_data_b_t  ; ///< Vector representing 'payload' data in bit type
typedef logic [31:0]  uvma_{{ name }}_data_l_t  ; ///< Vector representing 'payload' data in logi type
typedef bit   [ 1:0]  uvma_{{ name }}_tail_b_t  ; ///< Vector representing tail data in bit type
typedef logic [ 1:0]  uvma_{{ name }}_tail_l_t  ; ///< Vector representing tail data in logic type

/**
 * Enumerates all operational modes when uvma_{{ name }}_agent_c is active.
 */
typedef enum {
   UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_1.upper() }}, ///< TODO Describe {{ mode_1 }}
   UVMA_{{ name.upper() }}_DRV_MODE_{{ mode_2.upper() }}  ///< TODO Describe {{ mode_2 }}
} uvma_{{ name }}_mode_enum;

/**
 * Labels for data paths.
 */
typedef enum {
   UVMA_{{ name.upper() }}_DIRECTION_{{ tx.upper() }}, ///< TODO Describe {{ tx }}
   UVMA_{{ name.upper() }}_DIRECTION_{{ rx.upper() }}  ///< TODO Describe {{ rx }}
} uvma_{{ name }}_direction_enum;

/**
 * States for monitor's Finite State Machine.
 */
typedef enum {
   UVMA_{{ name.upper() }}_MON_FSM_INIT    , ///< Immediate state upon reset
   UVMA_{{ name.upper() }}_MON_FSM_TRAINING, ///< Looking for training sequence
   UVMA_{{ name.upper() }}_MON_FSM_SYNCING , ///< Looking for headers at constant interval
   UVMA_{{ name.upper() }}_MON_FSM_SYNCED    ///< Locked onto data stream
} uvma_{{ name }}_mon_fsm_enum;

/**
 * Transaction types.
 */
typedef enum bit [1:0] {
   UVMA_{{ name.upper() }}_HEADER_IDLE = 2'b01, ///< Contents are to be discarded
   UVMA_{{ name.upper() }}_HEADER_DATA = 2'b10  ///< Contents is 'payload' data
} uvma_{{ name }}_header_enum;


`endif // __UVMA_{{ name.upper() }}_TDEFS_SV__

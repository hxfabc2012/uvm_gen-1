// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ name_uppercase }}_ST_CONSTANTS_SV__
`define __UVMT_{{ name_uppercase }}_ST_CONSTANTS_SV__


const int unsigned uvmt_{{ name }}_st_default_clk_period          =    10_000; ///< Default clock period in ps
const int unsigned uvmt_{{ name }}_st_default_reset_period        =       100; ///< Default reset period in ns
const int unsigned uvmt_{{ name }}_st_default_startup_timeout     =    20_000; ///< Default Heartbeat Monitor startup timeout in ns
const int unsigned uvmt_{{ name }}_st_default_heartbeat_period    =     5_000; ///< Default Heartbeat Monitor period in ns
const int unsigned uvmt_{{ name }}_st_default_simulation_timeout  = 1_000_000; ///< Default Watchdog Timer simulation timeout in ns


`endif // __UVMT_{{ name_uppercase }}_ST_CONSTANTS_SV__

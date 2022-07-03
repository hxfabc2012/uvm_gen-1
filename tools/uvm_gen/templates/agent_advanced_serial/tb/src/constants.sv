// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__
`define __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__


const int unsigned uvmt_{{ name }}_st_default_clk_period          =    10_000; //   10 ns (100 Mhz) // TODO Set default clock period
const int unsigned uvmt_{{ name }}_st_default_reset_period        =       100; //  100 ns           // TODO Set default reset period
const int unsigned uvmt_{{ name }}_st_default_startup_timeout     =    10_000; //   10 us           // TODO Set default Heartbeat Monitor startup timeout
const int unsigned uvmt_{{ name }}_st_default_heartbeat_period    =    20_000; //    1 us           // TODO Set default Heartbeat Monitor period
const int unsigned uvmt_{{ name }}_st_default_simulation_timeout  = 1_000_000; //   .1 ms           // TODO Set default simulation timeout


`endif // __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__

// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__
`define __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__


const int unsigned uvmt_{{ name }}_st_default_clk_period          =    10_000; //  10 ns (100 Mhz)
const int unsigned uvmt_{{ name }}_st_default_reset_period        =       333; // 333 ns ( ~3 Mhz)
const int unsigned uvmt_{{ name }}_st_default_startup_timeout     =   100_000; //  .1 us
const int unsigned uvmt_{{ name }}_st_default_heartbeat_period    =     2_000; //  .02 us
const int unsigned uvmt_{{ name }}_st_default_simulation_timeout  =   500_000; // .5 ms


`endif // __UVMT_{{ upper(name) }}_ST_CONSTANTS_SV__

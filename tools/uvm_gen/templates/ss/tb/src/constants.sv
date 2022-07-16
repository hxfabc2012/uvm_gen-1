// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_CONSTANTS_SV__
`define __UVMT_${name_uppercase}_CONSTANTS_SV__


const int unsigned uvmt_${name}_default_startup_timeout     =     10_000; ///< Default Heartbeat Monitor startup timeout in ns
const int unsigned uvmt_${name}_default_heartbeat_period    =     20_000; ///< Default Heartbeat Monitor period in ns
const int unsigned uvmt_${name}_default_simulation_timeout  = 20_000_000; ///< Default Watchdog Timer simulation timeout in ns


`endif // __UVMT_${name_uppercase}_CONSTANTS_SV__

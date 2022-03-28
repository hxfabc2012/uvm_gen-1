// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMT_${name_uppercase}_CONSTANTS_SV__
`define __UVMT_${name_uppercase}_CONSTANTS_SV__


const int unsigned uvmt_${name}_default_startup_timeout     =    20_000; //  20 us // TODO Set default Heartbeat Monitor startup timeout
const int unsigned uvmt_${name}_default_heartbeat_period    =    20_000; //  20 us // TODO Set default Heartbeat Monitor period
const int unsigned uvmt_${name}_default_simulation_timeout  = 1_000_000; //   1 ms // TODO Set default simulation timeout


`endif // __UVMT_${name_uppercase}_CONSTANTS_SV__

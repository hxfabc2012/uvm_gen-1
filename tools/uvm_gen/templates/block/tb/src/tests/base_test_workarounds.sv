// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_${name_uppercase}_BASE_TEST_WORKAROUNDS_SV__
`define __UVMT_${name_uppercase}_BASE_TEST_WORKAROUNDS_SV__


// Temporary configuration constraints here (this file should be empty by the end of the project).
constraint no_sb_cons { env_cfg.scoreboarding_enabled == 0; } // TODO Remove this to enable scoreboards end-of-test error reporting!


`endif // __UVMT_${name_uppercase}_BASE_TEST_WORKAROUNDS_SV__

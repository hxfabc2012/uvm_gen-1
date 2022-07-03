// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_{{ upper(name) }}_CONSTANTS_SV__
`define __UVMA_{{ upper(name) }}_CONSTANTS_SV__


const int unsigned  uvma_{{ name }}_default_auser_width = `UVMA_{{ upper(name) }}_AUSER_DEFAULT_WIDTH; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_wuser_width = `UVMA_{{ upper(name) }}_WUSER_DEFAULT_WIDTH; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_ruser_width = `UVMA_{{ upper(name) }}_RUSER_DEFAULT_WIDTH; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_addr_width  = `UVMA_{{ upper(name) }}_ADDR_DEFAULT_WIDTH ; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_data_width  = `UVMA_{{ upper(name) }}_DATA_DEFAULT_WIDTH ; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_id_width    = `UVMA_{{ upper(name) }}_ID_DEFAULT_WIDTH   ; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_achk_width  = `UVMA_{{ upper(name) }}_ACHK_DEFAULT_WIDTH ; // Measured in bits (b)
const int unsigned  uvma_{{ name }}_default_rchk_width  = `UVMA_{{ upper(name) }}_RCHK_DEFAULT_WIDTH ; // Measured in bits (b)


`endif // __UVMA_{{ upper(name) }}_CONSTANTS_SV__

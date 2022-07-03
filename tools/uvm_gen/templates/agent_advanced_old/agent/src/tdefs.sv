// Copyright {{ year }} {{ name_of_copyright_owner }}
// {{ license }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVMA_{{ name_uppercase }}_TDEFS_SV__
`define __UVMA_{{ name_uppercase }}_TDEFS_SV__


// Logic vectors
typedef logic                                       uvma_{{ name }}_req_l_t      ;
typedef logic                                       uvma_{{ name }}_gnt_l_t      ;
typedef logic [(`UVMA_{{ name_uppercase }}_AUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_auser_l_t    ;
typedef logic [(`UVMA_{{ name_uppercase }}_WUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_wuser_l_t    ;
typedef logic [(`UVMA_{{ name_uppercase }}_RUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_ruser_l_t    ;
typedef logic [(`UVMA_{{ name_uppercase }}_ADDR_MAX_WIDTH    -1):0]  uvma_{{ name }}_addr_l_t     ;
typedef logic [(`UVMA_{{ name_uppercase }}_DATA_MAX_WIDTH    -1):0]  uvma_{{ name }}_data_l_t     ;
typedef logic                                       uvma_{{ name }}_we_l_t       ;
typedef logic [((`UVMA_{{ name_uppercase }}_DATA_MAX_WIDTH/8)-1):0]  uvma_{{ name }}_be_l_t       ;
typedef logic [(`UVMA_{{ name_uppercase }}_ID_MAX_WIDTH      -1):0]  uvma_{{ name }}_id_l_t       ;
typedef logic                                       uvma_{{ name }}_err_l_t      ;
typedef logic                                       uvma_{{ name }}_exokay_l_t   ;
typedef logic [5:0]                                 uvma_{{ name }}_atop_l_t     ;
typedef logic [1:0]                                 uvma_{{ name }}_memtype_l_t  ;
typedef logic [2:0]                                 uvma_{{ name }}_prot_l_t     ;
typedef logic                                       uvma_{{ name }}_reqpar_l_t   ;
typedef logic                                       uvma_{{ name }}_gntpar_l_t   ;
typedef logic [(`UVMA_{{ name_uppercase }}_ACHK_MAX_WIDTH    -1):0]  uvma_{{ name }}_achk_l_t     ;
typedef logic [(`UVMA_{{ name_uppercase }}_RCHK_MAX_WIDTH    -1):0]  uvma_{{ name }}_rchk_l_t     ;
typedef logic                                       uvma_{{ name }}_rvalid_l_t   ;
typedef logic                                       uvma_{{ name }}_rvalidpar_l_t;
typedef logic                                       uvma_{{ name }}_rready_l_t   ;
typedef logic                                       uvma_{{ name }}_rreadypar_l_t;

// Bit vectors
typedef bit                                       uvma_{{ name }}_req_b_t      ;
typedef bit                                       uvma_{{ name }}_gnt_b_t      ;
typedef bit [(`UVMA_{{ name_uppercase }}_AUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_auser_b_t    ;
typedef bit [(`UVMA_{{ name_uppercase }}_WUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_wuser_b_t    ;
typedef bit [(`UVMA_{{ name_uppercase }}_RUSER_MAX_WIDTH   -1):0]  uvma_{{ name }}_ruser_b_t    ;
typedef bit [(`UVMA_{{ name_uppercase }}_ADDR_MAX_WIDTH    -1):0]  uvma_{{ name }}_addr_b_t     ;
typedef bit [(`UVMA_{{ name_uppercase }}_DATA_MAX_WIDTH    -1):0]  uvma_{{ name }}_data_b_t     ;
typedef bit                                       uvma_{{ name }}_we_b_t       ;
typedef bit [((`UVMA_{{ name_uppercase }}_DATA_MAX_WIDTH/8)-1):0]  uvma_{{ name }}_be_b_t       ;
typedef bit [(`UVMA_{{ name_uppercase }}_ID_MAX_WIDTH      -1):0]  uvma_{{ name }}_id_b_t       ;
typedef bit                                       uvma_{{ name }}_err_b_t      ;
typedef bit                                       uvma_{{ name }}_exokay_b_t   ;
typedef bit [5:0]                                 uvma_{{ name }}_atop_b_t     ;
typedef bit [1:0]                                 uvma_{{ name }}_memtype_b_t  ;
typedef bit [2:0]                                 uvma_{{ name }}_prot_b_t     ;
typedef bit                                       uvma_{{ name }}_reqpar_b_t   ;
typedef bit                                       uvma_{{ name }}_gntpar_b_t   ;
typedef bit [(`UVMA_{{ name_uppercase }}_ACHK_MAX_WIDTH    -1):0]  uvma_{{ name }}_achk_b_t     ;
typedef bit [(`UVMA_{{ name_uppercase }}_RCHK_MAX_WIDTH    -1):0]  uvma_{{ name }}_rchk_b_t     ;
typedef bit                                       uvma_{{ name }}_rvalid_b_t   ;
typedef bit                                       uvma_{{ name }}_rvalidpar_b_t;
typedef bit                                       uvma_{{ name }}_rready_b_t   ;
typedef bit                                       uvma_{{ name }}_rreadypar_b_t;


typedef enum int unsigned {
   UVMA_{{ name_uppercase }}_VERSION_1P0 = 0,
   UVMA_{{ name_uppercase }}_VERSION_1P2 = 2
} uvma_{{ name }}_version_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_MODE_MSTR,
   UVMA_{{ name_uppercase }}_DRV_MODE_SLV
} uvma_{{ name }}_mode_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_IDLE_ZEROS ,
   UVMA_{{ name_uppercase }}_DRV_IDLE_RANDOM
} uvma_{{ name }}_drv_idle_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_ACCESS_READ ,
   UVMA_{{ name_uppercase }}_ACCESS_WRITE
} uvma_{{ name }}_access_type_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_SLV_GNT_MODE_CONSTANT      ,
   UVMA_{{ name_uppercase }}_DRV_SLV_GNT_MODE_FIXED_LATENCY ,
   UVMA_{{ name_uppercase }}_DRV_SLV_GNT_MODE_RANDOM_LATENCY
} uvma_{{ name }}_drv_slv_gnt_mode_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_SLV_RVALID_MODE_CONSTANT      ,
   UVMA_{{ name_uppercase }}_DRV_SLV_RVALID_MODE_FIXED_LATENCY ,
   UVMA_{{ name_uppercase }}_DRV_SLV_RVALID_MODE_RANDOM_LATENCY
} uvma_{{ name }}_drv_slv_rvalid_mode_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_SLV_ERR_MODE_OK,
   UVMA_{{ name_uppercase }}_DRV_SLV_ERR_MODE_RANDOM
} uvma_{{ name }}_drv_slv_err_mode_enum;

typedef enum {
   UVMA_{{ name_uppercase }}_DRV_SLV_EXOKAY_MODE_SUCCESS,
   UVMA_{{ name_uppercase }}_DRV_SLV_EXOKAY_MODE_RANDOM
} uvma_{{ name }}_drv_slv_exokay_mode_enum;


`endif // __UVMA_{{ name_uppercase }}_TDEFS_SV__

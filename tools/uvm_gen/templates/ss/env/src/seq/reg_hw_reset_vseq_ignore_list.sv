// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_IGNORE_LIST_SV__
`define __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_IGNORE_LIST_SV__


string  ignore_list[$] = '{
   // TODO Add registers and/or register blocks to ignore list for automated testing of reset values
   //      Ex: "block_name.reg_name", // One register at a time
   //      Ex: "block_name.*", // One block at a time
};


`endif // __UVME_${name_uppercase}_REG_HW_RESET_VSEQ_IGNORE_LIST_SV__

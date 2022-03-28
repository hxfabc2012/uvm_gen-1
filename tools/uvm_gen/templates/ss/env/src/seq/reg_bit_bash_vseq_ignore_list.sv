// Copyright ${year} ${name_of_copyright_owner}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: ${license_id}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



`ifndef __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_IGNORE_LIST_SV__
`define __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_IGNORE_LIST_SV__


string  ignore_list[$] = '{
   // TODO Add register blocks to ${name_normal_case} ignore list for RAL bit bash automated testing
   //      Ex: "block_name.reg_name", // One register at a time
   //      Ex: "block_name.*", // One block at a time
};


`endif // __UVME_${name_uppercase}_REG_BIT_BASH_VSEQ_IGNORE_LIST_SV__

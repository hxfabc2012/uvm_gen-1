// Copyright {{ year }} {{ name_of_copyright_owner }}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// {{ license }}
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_{{ upper(name) }}_ST_SLV_MON_TRN_SV__
`define __UVME_{{ upper(name) }}_ST_SLV_MON_TRN_SV__


/**
 * TODO Describe uvme_{{ name }}_st_slv_mon_trn_c
 */
class uvme_{{ name }}_st_slv_mon_trn_c extends uvma_{{ name }}_mon_trn_c;
   
   `uvm_object_utils(uvme_{{ name }}_st_slv_mon_trn_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_{{ name }}_st_slv_mon_trn");
   
   /**
    * TODO Describe uvme_{{ name }}_st_slv_mon_trn_c::do_compare()
    */
   extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
   
endclass : uvme_{{ name }}_st_slv_mon_trn_c


function uvme_{{ name }}_st_slv_mon_trn_c::new(string name="uvme_{{ name }}_st_slv_mon_trn");
   
   super.new(name);
   
endfunction : new


function bit uvme_{{ name }}_st_slv_mon_trn_c::do_compare(uvm_object rhs, uvm_comparer comparer);
   
   uvma_{{ name }}_mon_trn_c  rhs_;
   
   if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("UVME_{{ upper(name) }}_ST_SLV_MON_TRN", $sformatf("Could not cast 'rhs' (%s) to 'rhs_' (%s)", $typename(rhs), $typename(rhs_)))
   end
   
   do_compare = 1;
   if (rhs_.access_type == UVMA_{{ upper(name) }}_ACCESS_READ) begin
      do_compare &= comparer.compare_field_int("data", data, rhs_.data, $bits(data));
   end
   do_compare &= comparer.compare_field_int("err"   , err   , rhs_.err   , $bits(err   ));
   do_compare &= comparer.compare_field_int("ruser" , ruser , rhs_.ruser , $bits(ruser ));
   do_compare &= comparer.compare_field_int("rid"   , rid   , rhs_.rid   , $bits(rid   ));
   do_compare &= comparer.compare_field_int("exokay", exokay, rhs_.exokay, $bits(exokay));
   do_compare &= comparer.compare_field_int("rchk"  , rchk  , rhs_.rchk  , $bits(rchk  ));
   
endfunction : do_compare


`endif // __UVME_{{ upper(name) }}_ST_SLV_MON_TRN_SV__

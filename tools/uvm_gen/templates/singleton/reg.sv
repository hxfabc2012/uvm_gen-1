// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __${pkg_name_uppercase}_${name_uppercase}_REG_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_REG_SV__


/**
 * TODO Describe ${pkg_name}_${name}_reg_c
 */
class ${pkg_name}_${name}_reg_c extends ${base_class};

   // TODO Add register fields
   //      Ex: rand uvm_reg_field  xyz;


   `uvm_object_utils_begin(${pkg_name}_${name}_reg_c)
      // TODO Add field macros for register fields
      //      Ex: `uvm_field_object(xyz, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);

   /**
    * Creates and configures register fields.
    */
   extern function void build();

endclass : ${pkg_name}_${name}_reg_c


function ${pkg_name}_${name}_reg_c::new(string name="${pkg_name}_${name}_reg", int unsigned n_bits=32, int has_coverage=UVM_NO_COVERAGE);

   super.new(name, n_bits, has_coverage);

endfunction : new


function void ${pkg_name}_${name}_reg_c::build();

   // TODO Create and configure register fields
   //      Ex: xyz = uvm_reg_field::type_id::create("xyz");
   //          xyz.configure(
   //             .parent                 (this),
   //             .size                   (   1),
   //             .lsb_pos                (   0),
   //             .access                 ("RW"),
   //             .volatile               (   0),
   //             .reset                  (   0),
   //             .has_reset              (   1),
   //             .is_rand                (   1),
   //             .individually_accessible(   0)
   //          );

endfunction: build


`endif // __${pkg_name_uppercase}_${name_uppercase}_REG_SV__

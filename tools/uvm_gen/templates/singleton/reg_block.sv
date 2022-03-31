// Copyright ${year} ${name_of_copyright_owner}
// ${license}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __${pkg_name_uppercase}_${name_uppercase}_REG_BLOCK_SV__
`define __${pkg_name_uppercase}_${name_uppercase}_REG_BLOCK_SV__


/**
 * TODO Describe ${pkg_name}_${name}_reg_block_c
 */
class ${pkg_name}_${name}_reg_block_c extends ${base_class};

   longint unsigned  base_address;

   // Sub-Blocks
   // TODO Add sub-block(s)
   //      Ex: rand ${pkg_name}_${name}_abc_reg_block_c  abc;

   // Registers
   // TODO Add register(s)
   //      Ex: rand ${pkg_name}_${name}_xyz_reg_c  xyz;


   `uvm_object_utils_begin(${pkg_name}_${name}_reg_block_c)
      // TODO Add field macros for sub-block(s) and register(s)
      //      Ex: `uvm_field_object(abc, UVM_DEFAULT)
      //          `uvm_field_object(xyz, UVM_DEFAULT)
   `uvm_object_utils_end


   /**
    * Default constructor.
    */
   extern function new(string name="${pkg_name}_${name}_reg_block", int has_coverage=UVM_NO_COVERAGE);

   /**
    * Creates sub-block(s).
    */
   extern virtual function void create_blocks();

   /**
    * Creates register(s).
    */
   extern virtual function void create_regs();

   /**
    * Creates default register map.
    */
   extern virtual function void create_reg_map();

   /**
    * Adds register(s) to register map.
    */
   extern virtual function void add_regs_to_map();

endclass : ${pkg_name}_${name}_reg_block_c


function ${pkg_name}_${name}_reg_block_c::new(string name="${pkg_name}_${name}_reg_block", int has_coverage=UVM_NO_COVERAGE);

   super.new(name, has_coverage);

endfunction : new


function void ${pkg_name}_${name}_reg_block_c::create_blocks();

   // TODO Implement ${pkg_name}_${name}_reg_block_c::create_blocks()
   //      Ex: abc = ${pkg_name}_${name}_abc_reg_block_c::type_id::create("abc");
   //          abc.configure(this);
   //          abc.build();

endfunction : create_blocks


function void ${pkg_name}_${name}_reg_block_c::create_regs();

   // TODO Implement ${pkg_name}_${name}_reg_block_c::create_regs()
   //      Ex:  xyz = ${pkg_name}_${name}_xyz_reg_c::type_id::create("xyz");
   //           xyz.configure(this);
   //           xyz.build();

endfunction : create_regs


function void ${pkg_name}_${name}_reg_block_c::create_reg_map();

   default_map = create_map(
      .name     ("default_map"),
      .base_addr(base_address),
      .n_bytes  (4),
      .endian   (UVM_LITTLE_ENDIAN)
   );

endfunction : create_reg_map


function void ${pkg_name}_${name}_reg_block_c::add_regs_to_map();

   // TODO Implement ${pkg_name}_${name}_reg_block_c::add_regs_to_map()
   //      Ex: default_map.add_reg(
   //             .rg    (xyz),
   //             .offset(32'h00_00_00_00),
   //             .rights("RW")
   //          );

endfunction : add_regs_to_map


`endif // _${pkg_name_uppercase}_${name_uppercase}_REG_BLOCK_SV__

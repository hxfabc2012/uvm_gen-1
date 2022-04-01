#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
########################################################################################################################
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys
import re


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
uvm_gen_dir = re.sub("new_block.py", "", os.path.realpath(__file__)) + ".."
relative_path_to_template = uvm_gen_dir + "/templates/"
out_path = ""
default_copyright_owner = "Contributors"
default_license = "SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1"
name_of_copyright_owner = ""
name = ""
name_normal_case = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = { }

files = {
    #              SRC                                 DST
    #"block/agent_cp/bin/package.py"                  : "uvma_${name}/bin/package.py",
    #"block/agent_cp/docs/agent_block_diagram.svg"    : "uvma_${name}/docs/agent_block_diagram.svg",
    #"block/agent_cp/examples/instantiation.sv"       : "uvma_${name}/examples/instantiation.sv",
    #"block/agent_cp/examples/sequence.sv"            : "uvma_${name}/examples/sequence.sv",
    #"block/agent_cp/src/comps/agent.sv"              : "uvma_${name}/src/comps/uvma_${name}_cp_agent.sv",
    #"block/agent_cp/src/comps/cov_model.sv"          : "uvma_${name}/src/comps/uvma_${name}_cp_cov_model.sv",
    #"block/agent_cp/src/comps/drv.sv"                : "uvma_${name}/src/comps/uvma_${name}_cp_drv.sv",
    #"block/agent_cp/src/comps/logger.sv"             : "uvma_${name}/src/comps/uvma_${name}_cp_logger.sv",
    #"block/agent_cp/src/comps/mon.sv"                : "uvma_${name}/src/comps/uvma_${name}_cp_mon.sv",
    #"block/agent_cp/src/comps/sqr.sv"                : "uvma_${name}/src/comps/uvma_${name}_cp_sqr.sv",
    #"block/agent_cp/src/obj/cfg.sv"                  : "uvma_${name}/src/obj/uvma_${name}_cp_cfg.sv",
    #"block/agent_cp/src/obj/cntxt.sv"                : "uvma_${name}/src/obj/uvma_${name}_cp_cntxt.sv",
    #"block/agent_cp/src/obj/mon_trn.sv"              : "uvma_${name}/src/obj/uvma_${name}_cp_mon_trn.sv",
    #"block/agent_cp/src/seq/base_seq.sv"             : "uvma_${name}/src/seq/uvma_${name}_cp_base_seq.sv",
    #"block/agent_cp/src/seq/seq_item.sv"             : "uvma_${name}/src/seq/uvma_${name}_cp_seq_item.sv",
    #"block/agent_cp/src/seq/seq_lib.sv"              : "uvma_${name}/src/seq/uvma_${name}_cp_seq_lib.sv",
    #"block/agent_cp/src/constants.sv"                : "uvma_${name}/src/uvma_${name}_cp_constants.sv",
    #"block/agent_cp/src/if_chkr.sv"                  : "uvma_${name}/src/uvma_${name}_cp_if_chkr.sv",
    #"block/agent_cp/src/if.sv"                       : "uvma_${name}/src/uvma_${name}_cp_if.sv",
    #"block/agent_cp/src/macros.svh"                  : "uvma_${name}/src/uvma_${name}_cp_macros.svh",
    #"block/agent_cp/src/pkg.flist"                   : "uvma_${name}/src/uvma_${name}_cp_pkg.flist",
    #"block/agent_cp/src/pkg.flist.xsim"              : "uvma_${name}/src/uvma_${name}_cp_pkg.flist.xsim",
    #"block/agent_cp/src/pkg.sv"                      : "uvma_${name}/src/uvma_${name}_cp_pkg.sv",
    #"block/agent_cp/src/tdefs.sv"                    : "uvma_${name}/src/uvma_${name}_cp_tdefs.sv",
    #"block/agent_cp/gitignore"                       : "uvma_${name}/.gitignore",
    #"block/agent_cp/ip.yml"                          : "uvma_${name}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                      : "uvma_${name}/LICENSE.md",
    #"block/agent_cp/README.md"                       : "uvma_${name}/README.md",
    "block/agent_dp/bin/package.py"                  : "uvma_${name}_dp/bin/package.py",
    "block/agent_dp/docs/agent_block_diagram.svg"    : "uvma_${name}_dp/docs/agent_block_diagram.svg",
    "block/agent_dp/examples/instantiation.sv"       : "uvma_${name}_dp/examples/instantiation.sv",
    "block/agent_dp/examples/sequence.sv"            : "uvma_${name}_dp/examples/sequence.sv",
    "block/agent_dp/src/comps/agent.sv"              : "uvma_${name}_dp/src/comps/uvma_${name}_dp_agent.sv",
    "block/agent_dp/src/comps/cov_model.sv"          : "uvma_${name}_dp/src/comps/uvma_${name}_dp_cov_model.sv",
    "block/agent_dp/src/comps/drv.sv"                : "uvma_${name}_dp/src/comps/uvma_${name}_dp_drv.sv",
    "block/agent_dp/src/comps/logger.sv"             : "uvma_${name}_dp/src/comps/uvma_${name}_dp_logger.sv",
    "block/agent_dp/src/comps/mon.sv"                : "uvma_${name}_dp/src/comps/uvma_${name}_dp_mon.sv",
    "block/agent_dp/src/comps/sqr.sv"                : "uvma_${name}_dp/src/comps/uvma_${name}_dp_sqr.sv",
    "block/agent_dp/src/obj/cfg.sv"                  : "uvma_${name}_dp/src/obj/uvma_${name}_dp_cfg.sv",
    "block/agent_dp/src/obj/cntxt.sv"                : "uvma_${name}_dp/src/obj/uvma_${name}_dp_cntxt.sv",
    "block/agent_dp/src/obj/mon_in_trn.sv"           : "uvma_${name}_dp/src/obj/uvma_${name}_dp_mon_in_trn.sv",
    "block/agent_dp/src/obj/mon_out_trn.sv"          : "uvma_${name}_dp/src/obj/uvma_${name}_dp_mon_out_trn.sv",
    "block/agent_dp/src/seq/base_seq.sv"             : "uvma_${name}_dp/src/seq/uvma_${name}_dp_base_seq.sv",
    "block/agent_dp/src/seq/seq_item.sv"             : "uvma_${name}_dp/src/seq/uvma_${name}_dp_seq_item.sv",
    "block/agent_dp/src/seq/seq_lib.sv"              : "uvma_${name}_dp/src/seq/uvma_${name}_dp_seq_lib.sv",
    "block/agent_dp/src/constants.sv"                : "uvma_${name}_dp/src/uvma_${name}_dp_constants.sv",
    "block/agent_dp/src/if_chkr.sv"                  : "uvma_${name}_dp/src/uvma_${name}_dp_if_chkr.sv",
    "block/agent_dp/src/if.sv"                       : "uvma_${name}_dp/src/uvma_${name}_dp_if.sv",
    "block/agent_dp/src/macros.svh"                  : "uvma_${name}_dp/src/uvma_${name}_dp_macros.svh",
    "block/agent_dp/src/pkg.flist"                   : "uvma_${name}_dp/src/uvma_${name}_dp_pkg.flist",
    "block/agent_dp/src/pkg.flist.xsim"              : "uvma_${name}_dp/src/uvma_${name}_dp_pkg.flist.xsim",
    "block/agent_dp/src/pkg.sv"                      : "uvma_${name}_dp/src/uvma_${name}_dp_pkg.sv",
    "block/agent_dp/src/tdefs.sv"                    : "uvma_${name}_dp/src/uvma_${name}_dp_tdefs.sv",
    "block/agent_dp/gitignore"                       : "uvma_${name}_dp/.gitignore",
    "block/agent_dp/ip.yml"                          : "uvma_${name}_dp/ip.yml",
    "LICENSE_solderpad_v2p1.md"                      : "uvma_${name}_dp/LICENSE.md",
    "block/agent_dp/README.md"                       : "uvma_${name}_dp/README.md"
#    "block/env/bin/package.py"                    : "uvme_${name}_st/bin/package.py",
#    "block/env/docs/env_block_diagram.svg"        : "uvme_${name}_st/docs/env_block_diagram.svg",
#    "block/env/examples/virtual_sequence.sv"      : "uvme_${name}_st/examples/virtual_sequence.sv",
#    "block/env/src/comps/cov_model.sv"            : "uvme_${name}_st/src/comps/uvme_${name}_st_cov_model.sv",
#    "block/env/src/comps/env.sv"                  : "uvme_${name}_st/src/comps/uvme_${name}_st_env.sv",
#    "block/env/src/comps/prd.sv"                  : "uvme_${name}_st/src/comps/uvme_${name}_st_prd.sv",
#    "block/env/src/comps/vsqr.sv"                 : "uvme_${name}_st/src/comps/uvme_${name}_st_vsqr.sv",
#    "block/env/src/obj/cfg.sv"                    : "uvme_${name}_st/src/obj/uvme_${name}_st_cfg.sv",
#    "block/env/src/obj/cntxt.sv"                  : "uvme_${name}_st/src/obj/uvme_${name}_st_cntxt.sv",
#    "block/env/src/seq/base_vseq.sv"              : "uvme_${name}_st/src/seq/uvme_${name}_st_base_vseq.sv",
#    "block/env/src/seq/rand_stim_vseq.sv"         : "uvme_${name}_st/src/seq/uvme_${name}_st_rand_stim_vseq.sv",
#    "block/env/src/seq/vseq_lib.sv"               : "uvme_${name}_st/src/seq/uvme_${name}_st_vseq_lib.sv",
#    "block/env/src/chkr.sv"                       : "uvme_${name}_st/src/uvme_${name}_st_chkr.sv",
#    "block/env/src/constants.sv"                  : "uvme_${name}_st/src/uvme_${name}_st_constants.sv",
#    "block/env/src/macros.svh"                    : "uvme_${name}_st/src/uvme_${name}_st_macros.svh",
#    "block/env/src/pkg.flist"                     : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist",
#    "block/env/src/pkg.flist.xsim"                : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist.xsim",
#    "block/env/src/pkg.sv"                        : "uvme_${name}_st/src/uvme_${name}_st_pkg.sv",
#    "block/env/src/tdefs.sv"                      : "uvme_${name}_st/src/uvme_${name}_st_tdefs.sv",
#    "block/env/gitignore"                         : "uvme_${name}_st/.gitignore",
#    "block/env/ip.yml"                            : "uvme_${name}_st/ip.yml",
#    "LICENSE_solderpad_v2p1.md"                         : "uvme_${name}_st/LICENSE.md",
#    "block/env/README.md"                         : "uvme_${name}_st/README.md",
#    "block/tb/bin/package.py"                     : "uvmt_${name}_st/bin/package.py",
#    "block/tb/docs/tb_block_diagram.svg"          : "uvmt_${name}_st/docs/tb_block_diagram.svg",
#    "block/tb/examples/test.sv"                   : "uvmt_${name}_st/examples/test.sv",
#    "block/tb/src/tb/clknrst_gen_if.sv"           : "uvmt_${name}_st/src/tb/uvmt_${name}_st_clknrst_gen_if.sv",
#    "block/tb/src/tb/dut_chkr.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_chkr.sv",
#    "block/tb/src/tb/dut_wrap.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_wrap.sv",
#    "block/tb/src/tb/tb.sv"                       : "uvmt_${name}_st/src/tb/uvmt_${name}_st_tb.sv",
#    "block/tb/src/tests/base_test_workarounds.sv" : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test_workarounds.sv",
#    "block/tb/src/tests/base_test.sv"             : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test.sv",
#    "block/tb/src/tests/rand_stim_test.sv"        : "uvmt_${name}_st/src/tests/uvmt_${name}_st_rand_stim_test.sv",
#    "block/tb/src/tests/test_cfg.sv"              : "uvmt_${name}_st/src/tests/uvmt_${name}_st_test_cfg.sv",
#    "block/tb/src/constants.sv"                   : "uvmt_${name}_st/src/uvmt_${name}_st_constants.sv",
#    "block/tb/src/macros.svh"                     : "uvmt_${name}_st/src/uvmt_${name}_st_macros.svh",
#    "block/tb/src/pkg.flist"                      : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist",
#    "block/tb/src/pkg.flist.xsim"                 : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist.xsim",
#    "block/tb/src/pkg.sv"                         : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.sv",
#    "block/tb/src/tdefs.sv"                       : "uvmt_${name}_st/src/uvmt_${name}_st_tdefs.sv",
#    "block/tb/gitignore"                          : "uvmt_${name}_st/.gitignore",
#    "block/tb/ip.yml"                             : "uvmt_${name}_st/ip.yml",
#    "LICENSE_solderpad_v2p1.md"                         : "uvmt_${name}_st/LICENSE.md",
#    "block/tb/README.md"                          : "uvmt_${name}_st/README.md"
}

directories = [
    #"uvma_${name}_cp",
    #"uvma_${name}_cp/bin",
    #"uvma_${name}_cp/docs",
    #"uvma_${name}_cp/examples",
    #"uvma_${name}_cp/src",
    #"uvma_${name}_cp/src/comps",
    #"uvma_${name}_cp/src/obj",
    #"uvma_${name}_cp/src/seq",
    "uvma_${name}_dp",
    "uvma_${name}_dp/bin",
    "uvma_${name}_dp/docs",
    "uvma_${name}_dp/examples",
    "uvma_${name}_dp/src",
    "uvma_${name}_dp/src/comps",
    "uvma_${name}_dp/src/obj",
    "uvma_${name}_dp/src/seq"
    #"uvme_${name}",
    #"uvme_${name}/bin",
    #"uvme_${name}/docs",
    #"uvme_${name}/examples",
    #"uvme_${name}/src",
    #"uvme_${name}/src/comps",
    #"uvme_${name}/src/obj",
    #"uvme_${name}/src/seq",
    #"uvmt_${name}",
    #"uvmt_${name}/bin",
    #"uvmt_${name}/docs",
    #"uvmt_${name}/examples",
    #"uvmt_${name}/src",
    #"uvmt_${name}/src/tb",
    #"uvmt_${name}/src/tests"
]


########################################################################################################################
# MAIN
########################################################################################################################
def process_file(path, file_path_template):
    if dbg:
        print("Processing file " + path + " with path template " + file_path_template)
    
    if not dbg:
        fin = open(relative_path_to_template + path, "rt")
    
    fout_path = file_path_template
    for param in parameters:
        fout_path = fout_path.replace("${" + param + "}", str(parameters[param]))
    fout_path = out_path + "/" + fout_path
    if dbg:
        print("Templated path: " + fout_path)
    else:
        fout = open(fout_path, "w+")
        data = fin.read()
    
    for param in parameters:
        if dbg:
            print("Replacing string '${" + param + "}' with '" + str(parameters[param]) + "'")
        else:
            data = data.replace("${" + param + "}", str(parameters[param]))
    
    if not dbg:
        fin.close()
        print("Writing " + fout_path)
        fout.write(data)
        fout.close()
    
def process_all_files():
    for file in files:
        process_file(file, files[file])

def create_directories():
    for dir in directories:
        dir_name = out_path + "/" + dir
        for param in parameters:
            dir_name = dir_name.replace("${" + param + "}", str(parameters[param]))
        if dbg:
            print("Creating directory '" + dir_name + "'")
        else:
            os.mkdir(dir_name)

def pick_out_path():
    global out_path
    global default_copyright_owner
    if len(sys.argv) > 1:
        out_path = sys.argv[1]
        print("Code will be output to " + out_path)
    if len(sys.argv) > 2:
        default_copyright_owner = sys.argv[2].replace('"', "")
        print("Default copyright owner is " + default_copyright_owner)

def prompt_user_values():
    global out_path
    global name
    global name_normal_case
    global name_of_copyright_owner
    global default_copyright_owner
    global parameters
    
    print("Moore.io Template Generator: RTL Block UVM DV Combo (v1p0)")
    print("******************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Agent")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    
    license = input("Please enter a usage license or hit RETURN for the default (default is '" + default_license + "'):\n").strip()
    if license == "":
        license = default_license
    
    name = input("Please enter the package name for this block (ex: 'apb'); this name will be used for all UVM types (ex: 'uvma_apb_cp_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    
    name_normal_case = input("Please enter the (descriptive) name for this block (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    
    parameters = {
    "name"                    : name,
    "name_uppercase"          : name.upper(),
    "name_normal_case"        : name_normal_case,
    "name_of_copyright_owner" : name_of_copyright_owner,
    "license"                 : license,
    "year"                    : date.today().year
}


def print_end_message():
    print("Code successfully generated")


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
print_end_message()

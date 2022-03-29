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


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
relative_path_to_template = os.getcwd() + "/../templates/"
out_path = ""
default_copyright_owner = ""
name_of_copyright_owner = ""
name = ""
name_normal_case = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = {
    "name"                    : "",
    "name_uppercase"          : "",
    "name_normal_case"        : "",
    "name_of_copyright_owner" : "",
    "year"                    : date.today().year
}

files = {
    #              SRC                                 DST
    "agent_basic/agent/bin/package.py"                  : "uvma_${name}/bin/package.py",
    "agent_basic/agent/docs/agent_block_diagram.svg"    : "uvma_${name}/docs/agent_block_diagram.svg",
    "agent_basic/agent/examples/instantiation.sv"       : "uvma_${name}/examples/instantiation.sv",
    "agent_basic/agent/examples/sequence.sv"            : "uvma_${name}/examples/sequence.sv",
    "agent_basic/agent/src/comps/agent.sv"              : "uvma_${name}/src/comps/uvma_${name}_agent.sv",
    "agent_basic/agent/src/comps/cov_model.sv"          : "uvma_${name}/src/comps/uvma_${name}_cov_model.sv",
    "agent_basic/agent/src/comps/drv.sv"                : "uvma_${name}/src/comps/uvma_${name}_drv.sv",
    "agent_basic/agent/src/comps/logger.sv"             : "uvma_${name}/src/comps/uvma_${name}_logger.sv",
    "agent_basic/agent/src/comps/mon.sv"                : "uvma_${name}/src/comps/uvma_${name}_mon.sv",
    "agent_basic/agent/src/comps/sqr.sv"                : "uvma_${name}/src/comps/uvma_${name}_sqr.sv",
    "agent_basic/agent/src/obj/cfg.sv"                  : "uvma_${name}/src/obj/uvma_${name}_cfg.sv",
    "agent_basic/agent/src/obj/cntxt.sv"                : "uvma_${name}/src/obj/uvma_${name}_cntxt.sv",
    "agent_basic/agent/src/obj/mon_trn.sv"              : "uvma_${name}/src/obj/uvma_${name}_mon_trn.sv",
    "agent_basic/agent/src/seq/base_seq.sv"             : "uvma_${name}/src/seq/uvma_${name}_base_seq.sv",
    "agent_basic/agent/src/seq/seq_item.sv"             : "uvma_${name}/src/seq/uvma_${name}_seq_item.sv",
    "agent_basic/agent/src/constants.sv"                : "uvma_${name}/src/uvma_${name}_constants.sv",
    "agent_basic/agent/src/if_chkr.sv"                  : "uvma_${name}/src/uvma_${name}_if_chkr.sv",
    "agent_basic/agent/src/if.sv"                       : "uvma_${name}/src/uvma_${name}_if.sv",
    "agent_basic/agent/src/macros.svh"                  : "uvma_${name}/src/uvma_${name}_macros.svh",
    "agent_basic/agent/src/pkg.flist"                   : "uvma_${name}/src/uvma_${name}_pkg.flist",
    "agent_basic/agent/src/pkg.flist.xsim"              : "uvma_${name}/src/uvma_${name}_pkg.flist.xsim",
    "agent_basic/agent/src/pkg.sv"                      : "uvma_${name}/src/uvma_${name}_pkg.sv",
    "agent_basic/agent/src/tdefs.sv"                    : "uvma_${name}/src/uvma_${name}_tdefs.sv",
    "agent_basic/agent/gitignore"                       : "uvma_${name}/.gitignore",
    "agent_basic/agent/ip.yml"                          : "uvma_${name}/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvma_${name}/LICENSE.md",
    "agent_basic/agent/README.md"                       : "uvma_${name}/README.md",
    "agent_basic/env/bin/package.py"                    : "uvme_${name}_st/bin/package.py",
    "agent_basic/env/docs/env_block_diagram.svg"        : "uvme_${name}_st/docs/env_block_diagram.svg",
    "agent_basic/env/examples/virtual_sequence.sv"      : "uvme_${name}_st/examples/virtual_sequence.sv",
    "agent_basic/env/src/comps/cov_model.sv"            : "uvme_${name}_st/src/comps/uvme_${name}_st_cov_model.sv",
    "agent_basic/env/src/comps/env.sv"                  : "uvme_${name}_st/src/comps/uvme_${name}_st_env.sv",
    "agent_basic/env/src/comps/prd.sv"                  : "uvme_${name}_st/src/comps/uvme_${name}_st_prd.sv",
    "agent_basic/env/src/comps/vsqr.sv"                 : "uvme_${name}_st/src/comps/uvme_${name}_st_vsqr.sv",
    "agent_basic/env/src/obj/cfg.sv"                    : "uvme_${name}_st/src/obj/uvme_${name}_st_cfg.sv",
    "agent_basic/env/src/obj/cntxt.sv"                  : "uvme_${name}_st/src/obj/uvme_${name}_st_cntxt.sv",
    "agent_basic/env/src/seq/base_vseq.sv"              : "uvme_${name}_st/src/seq/uvme_${name}_st_base_vseq.sv",
    "agent_basic/env/src/seq/vseq_lib.sv"               : "uvme_${name}_st/src/seq/uvme_${name}_st_vseq_lib.sv",
    "agent_basic/env/src/chkr.sv"                       : "uvme_${name}_st/src/uvme_${name}_st_chkr.sv",
    "agent_basic/env/src/constants.sv"                  : "uvme_${name}_st/src/uvme_${name}_st_constants.sv",
    "agent_basic/env/src/macros.svh"                    : "uvme_${name}_st/src/uvme_${name}_st_macros.svh",
    "agent_basic/env/src/pkg.flist"                     : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist",
    "agent_basic/env/src/pkg.flist.xsim"                : "uvme_${name}_st/src/uvme_${name}_st_pkg.flist.xsim",
    "agent_basic/env/src/pkg.sv"                        : "uvme_${name}_st/src/uvme_${name}_st_pkg.sv",
    "agent_basic/env/src/tdefs.sv"                      : "uvme_${name}_st/src/uvme_${name}_st_tdefs.sv",
    "agent_basic/env/gitignore"                         : "uvme_${name}_st/.gitignore",
    "agent_basic/env/ip.yml"                            : "uvme_${name}_st/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvme_${name}_st/LICENSE.md",
    "agent_basic/env/README.md"                         : "uvme_${name}_st/README.md",
    "agent_basic/tb/bin/package.py"                     : "uvmt_${name}_st/bin/package.py",
    "agent_basic/tb/docs/tb_block_diagram.svg"          : "uvmt_${name}_st/docs/tb_block_diagram.svg",
    "agent_basic/tb/examples/test.sv"                   : "uvmt_${name}_st/examples/test.sv",
    "agent_basic/tb/src/tb/clknrst_gen_if.sv"           : "uvmt_${name}_st/src/tb/uvmt_${name}_st_clknrst_gen_if.sv",
    "agent_basic/tb/src/tb/dut_chkr.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_chkr.sv",
    "agent_basic/tb/src/tb/dut_wrap.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_wrap.sv",
    "agent_basic/tb/src/tb/tb.sv"                       : "uvmt_${name}_st/src/tb/uvmt_${name}_st_tb.sv",
    "agent_basic/tb/src/tests/base_test_workarounds.sv" : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test_workarounds.sv",
    "agent_basic/tb/src/tests/base_test.sv"             : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test.sv",
    "agent_basic/tb/src/tests/test_cfg.sv"              : "uvmt_${name}_st/src/tests/uvmt_${name}_st_test_cfg.sv",
    "agent_basic/tb/src/constants.sv"                   : "uvmt_${name}_st/src/uvmt_${name}_st_constants.sv",
    "agent_basic/tb/src/macros.svh"                     : "uvmt_${name}_st/src/uvmt_${name}_st_macros.svh",
    "agent_basic/tb/src/pkg.flist"                      : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist",
    "agent_basic/tb/src/pkg.flist.xsim"                 : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist.xsim",
    "agent_basic/tb/src/pkg.sv"                         : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.sv",
    "agent_basic/tb/src/tdefs.sv"                       : "uvmt_${name}_st/src/uvmt_${name}_st_tdefs.sv",
    "agent_basic/tb/gitignore"                          : "uvmt_${name}_st/.gitignore",
    "agent_basic/tb/ip.yml"                             : "uvmt_${name}_st/ip.yml",
    "LICENSE_solderpad_v2p1.md"                         : "uvmt_${name}_st/LICENSE.md",
    "agent_basic/tb/README.md"                          : "uvmt_${name}_st/README.md"
}

directories = [
    "uvma_${name}",
    "uvma_${name}/bin",
    "uvma_${name}/docs",
    "uvma_${name}/examples",
    "uvma_${name}/src",
    "uvma_${name}/src/comps",
    "uvma_${name}/src/obj",
    "uvma_${name}/src/seq",
    "uvme_${name}_st",
    "uvme_${name}_st/bin",
    "uvme_${name}_st/docs",
    "uvme_${name}_st/examples",
    "uvme_${name}_st/src",
    "uvme_${name}_st/src/comps",
    "uvme_${name}_st/src/obj",
    "uvme_${name}_st/src/seq",
    "uvmt_${name}_st",
    "uvmt_${name}_st/bin",
    "uvmt_${name}_st/docs",
    "uvmt_${name}_st/examples",
    "uvmt_${name}_st/src",
    "uvmt_${name}_st/src/tb",
    "uvmt_${name}_st/src/tests"
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
    
    print("Moore.io Template Generator: UVM Agent - Basic (v1p1)")
    print("******************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Agent")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new agent (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = input("Please enter the package name for this agent (ex: 'apb'); this name will be used for all agent types (ex: 'uvma_apb_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this agent (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    parameters = {
    "name"                    : name,
    "name_uppercase"          : name.upper(),
    "name_normal_case"        : name_normal_case,
    "name_of_copyright_owner" : name_of_copyright_owner,
    "year"                    : date.today().year,
    "name_1"                  : "active",
    "name_2"                  : "passive"
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

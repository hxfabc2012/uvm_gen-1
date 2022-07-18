#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
# All rights reserved
########################################################################################################################


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys
import re
import jinja2
from jinja2 import Template


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = True
uvm_gen_dir = re.sub("new_agent_advanced_serial.py", "", os.path.realpath(__file__)) + ".."
relative_path_to_template = uvm_gen_dir + "/templates/"
out_path = ""
default_copyright_owner = "Contributors"
default_license = "SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1"
name_of_copyright_owner = ""
name = ""
full_name = ""


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
parameters = { }

symmetric_phy_agent_files = {
    #              SRC                                 DST
    #"agent_advanced_serial/agent/bin/package.py"                  : "uvma_${name}/bin/package.py",
    #"agent_advanced_serial/agent/docs/agent_block_diagram.svg"    : "uvma_${name}/docs/agent_block_diagram.svg",
    "agent_advanced_serial/agent/examples/instantiation.sv"       : "uvma_${name}/examples/instantiation.sv",
    "agent_advanced_serial/agent/examples/sequence.sv"            : "uvma_${name}/examples/sequence.sv",
    "agent_advanced_serial/agent/src/comps/agent.sv"              : "uvma_{{ name }}/src/comps/uvma_{{ name }}_agent.sv",
    "agent_advanced_serial/agent/src/comps/cov_model.sv"          : "uvma_{{ name }}/src/comps/uvma_{{ name }}_cov_model.sv",
    "agent_advanced_serial/agent/src/comps/drv.sv"                : "uvma_{{ name }}/src/comps/uvma_{{ name }}_drv.sv",
    "agent_advanced_serial/agent/src/comps/logger.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_logger.sv",
    "agent_advanced_serial/agent/src/comps/mon.sv"                : "uvma_{{ name }}/src/comps/uvma_{{ name }}_mon.sv",
    "agent_advanced_serial/agent/src/comps/phy_drv.sv"            : "uvma_{{ name }}/src/comps/uvma_{{ name }}_phy_drv.sv",
    "agent_advanced_serial/agent/src/comps/phy_sqr.sv"            : "uvma_{{ name }}/src/comps/uvma_{{ name }}_phy_sqr.sv",
    "agent_advanced_serial/agent/src/comps/vsqr.sv"               : "uvma_{{ name }}/src/comps/uvma_{{ name }}_vsqr.sv",
    "agent_advanced_serial/agent/src/obj/cfg.sv"                  : "uvma_{{ name }}/src/obj/uvma_{{ name }}_cfg.sv",
    "agent_advanced_serial/agent/src/obj/cntxt.sv"                : "uvma_{{ name }}/src/obj/uvma_{{ name }}_cntxt.sv",
    "agent_advanced_serial/agent/src/obj/mon_fsm_cntxt.sv"        : "uvma_{{ name }}/src/obj/uvma_{{ name }}_mon_fsm_cntxt.sv",
    "agent_advanced_serial/agent/src/obj/mon_trn.sv"              : "uvma_{{ name }}/src/obj/uvma_{{ name }}_mon_trn.sv",
    "agent_advanced_serial/agent/src/obj/phy_mon_trn.sv"          : "uvma_{{ name }}/src/obj/uvma_{{ name }}_phy_mon_trn.sv",
    "agent_advanced_serial/agent/src/seq/base_vseq.sv"            : "uvma_{{ name }}/src/seq/uvma_{{ name }}_base_vseq.sv",
    "agent_advanced_serial/agent/src/seq/idle_vseq.sv"            : "uvma_{{ name }}/src/seq/uvma_{{ name }}_idle_vseq.sv",
    "agent_advanced_serial/agent/src/seq/mon_vseq.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_mon_vseq.sv",
    "agent_advanced_serial/agent/src/seq/phy_drv_vseq.sv"         : "uvma_{{ name }}/src/seq/uvma_{{ name }}_phy_drv_vseq.sv",
    "agent_advanced_serial/agent/src/seq/phy_seq_item.sv"         : "uvma_{{ name }}/src/seq/uvma_{{ name }}_phy_seq_item.sv",
    "agent_advanced_serial/agent/src/seq/seq_item.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_seq_item.sv",
    "agent_advanced_serial/agent/src/seq/training_vseq.sv"        : "uvma_{{ name }}/src/seq/uvma_{{ name }}_training_vseq.sv",
    "agent_advanced_serial/agent/src/seq/transport_base_vseq.sv"  : "uvma_{{ name }}/src/seq/uvma_{{ name }}_transport_base_vseq.sv",
    "agent_advanced_serial/agent/src/seq/vseq_lib.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_vseq_lib.sv",
    "agent_advanced_serial/agent/src/constants.sv"                : "uvma_{{ name }}/src/uvma_{{ name }}_constants.sv",
    "agent_advanced_serial/agent/src/if_chkr.sv"                  : "uvma_{{ name }}/src/uvma_{{ name }}_if_chkr.sv",
    "agent_advanced_serial/agent/src/if.sv"                       : "uvma_{{ name }}/src/uvma_{{ name }}_if.sv",
    "agent_advanced_serial/agent/src/macros.svh"                  : "uvma_{{ name }}/src/uvma_{{ name }}_macros.svh",
    "agent_advanced_serial/agent/src/pkg.flist"                   : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.flist",
    "agent_advanced_serial/agent/src/pkg.flist.xsim"              : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.flist.xsim",
    "agent_advanced_serial/agent/src/pkg.sv"                      : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.sv",
    "agent_advanced_serial/agent/src/tdefs.sv"                    : "uvma_{{ name }}/src/uvma_{{ name }}_tdefs.sv",
    "agent_advanced_serial/agent/gitignore"                       : "uvma_{{ name }}/.gitignore",
    "agent_advanced_serial/agent/ip.yml"                          : "uvma_{{ name }}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                         : "uvma_{{ name }}/LICENSE.md",
    "agent_advanced_serial/agent/README.md"                       : "uvma_{{ name }}/README.md"
}

asymmetric_phy_agent_files = {
    #              SRC                                 DST
    #"agent_advanced_serial/agent/bin/package.py"                  : "uvma_{{ name }}/bin/package.py",
    #"agent_advanced_serial/agent/docs/agent_block_diagram.svg"    : "uvma_{{ name }}/docs/agent_block_diagram.svg",
    "agent_advanced_serial/agent/examples/instantiation.sv"       : "uvma_{{ name }}/examples/instantiation.sv",
    "agent_advanced_serial/agent/examples/sequence.sv"            : "uvma_{{ name }}/examples/sequence.sv",
    "agent_advanced_serial/agent/src/comps/agent.sv"              : "uvma_{{ name }}/src/comps/uvma_{{ name }}_agent.sv",
    "agent_advanced_serial/agent/src/comps/cov_model.sv"          : "uvma_{{ name }}/src/comps/uvma_{{ name }}_cov_model.sv",
    "agent_advanced_serial/agent/src/comps/drv.sv"                : "uvma_{{ name }}/src/comps/uvma_{{ name }}_drv.sv",
    "agent_advanced_serial/agent/src/comps/logger.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_logger.sv",
    "agent_advanced_serial/agent/src/comps/mon.sv"                : "uvma_{{ name }}/src/comps/uvma_{{ name }}_mon.sv",
    "agent_advanced_serial/agent/src/comps/tx_drv.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_{{ tx }}_drv.sv",
    "agent_advanced_serial/agent/src/comps/tx_sqr.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_{{ tx }}_sqr.sv",
    "agent_advanced_serial/agent/src/comps/rx_drv.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_{{ rx }}_drv.sv",
    "agent_advanced_serial/agent/src/comps/rx_sqr.sv"             : "uvma_{{ name }}/src/comps/uvma_{{ name }}_{{ rx }}_sqr.sv",
    "agent_advanced_serial/agent/src/comps/vsqr.sv"               : "uvma_{{ name }}/src/comps/uvma_{{ name }}_vsqr.sv",
    "agent_advanced_serial/agent/src/obj/cfg.sv"                  : "uvma_{{ name }}/src/obj/uvma_{{ name }}_cfg.sv",
    "agent_advanced_serial/agent/src/obj/cntxt.sv"                : "uvma_{{ name }}/src/obj/uvma_{{ name }}_cntxt.sv",
    "agent_advanced_serial/agent/src/obj/mon_fsm_cntxt.sv"        : "uvma_{{ name }}/src/obj/uvma_{{ name }}_mon_fsm_cntxt.sv",
    "agent_advanced_serial/agent/src/obj/mon_trn.sv"              : "uvma_{{ name }}/src/obj/uvma_{{ name }}_mon_trn.sv",
    "agent_advanced_serial/agent/src/obj/tx_mon_trn.sv"           : "uvma_{{ name }}/src/obj/uvma_{{ name }}_{{ tx }}_mon_trn.sv",
    "agent_advanced_serial/agent/src/obj/rx_mon_trn.sv"           : "uvma_{{ name }}/src/obj/uvma_{{ name }}_{{ rx }}_mon_trn.sv",
    "agent_advanced_serial/agent/src/seq/base_vseq.sv"            : "uvma_{{ name }}/src/seq/uvma_{{ name }}_base_vseq.sv",
    "agent_advanced_serial/agent/src/seq/idle_vseq.sv"            : "uvma_{{ name }}/src/seq/uvma_{{ name }}_idle_vseq.sv",
    "agent_advanced_serial/agent/src/seq/mon_vseq.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_mon_vseq.sv",
    "agent_advanced_serial/agent/src/seq/tx_drv_vseq.sv"          : "uvma_{{ name }}/src/seq/uvma_{{ name }}_{{ tx }}_drv_vseq.sv",
    "agent_advanced_serial/agent/src/seq/tx_seq_item.sv"          : "uvma_{{ name }}/src/seq/uvma_{{ name }}_{{ tx }}_seq_item.sv",
    "agent_advanced_serial/agent/src/seq/rx_drv_vseq.sv"          : "uvma_{{ name }}/src/seq/uvma_{{ name }}_{{ rx }}_drv_vseq.sv",
    "agent_advanced_serial/agent/src/seq/rx_seq_item.sv"          : "uvma_{{ name }}/src/seq/uvma_{{ name }}_{{ rx }}_seq_item.sv",
    "agent_advanced_serial/agent/src/seq/seq_item.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_seq_item.sv",
    "agent_advanced_serial/agent/src/seq/training_vseq.sv"        : "uvma_{{ name }}/src/seq/uvma_{{ name }}_training_vseq.sv",
    "agent_advanced_serial/agent/src/seq/transport_base_vseq.sv"  : "uvma_{{ name }}/src/seq/uvma_{{ name }}_transport_base_vseq.sv",
    "agent_advanced_serial/agent/src/seq/vseq_lib.sv"             : "uvma_{{ name }}/src/seq/uvma_{{ name }}_vseq_lib.sv",
    "agent_advanced_serial/agent/src/constants.sv"                : "uvma_{{ name }}/src/uvma_{{ name }}_constants.sv",
    "agent_advanced_serial/agent/src/if_chkr.sv"                  : "uvma_{{ name }}/src/uvma_{{ name }}_if_chkr.sv",
    "agent_advanced_serial/agent/src/if.sv"                       : "uvma_{{ name }}/src/uvma_{{ name }}_if.sv",
    "agent_advanced_serial/agent/src/macros.svh"                  : "uvma_{{ name }}/src/uvma_{{ name }}_macros.svh",
    "agent_advanced_serial/agent/src/pkg.flist"                   : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.flist",
    "agent_advanced_serial/agent/src/pkg.flist.xsim"              : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.flist.xsim",
    "agent_advanced_serial/agent/src/pkg.sv"                      : "uvma_{{ name }}/src/uvma_{{ name }}_pkg.sv",
    "agent_advanced_serial/agent/src/tdefs.sv"                    : "uvma_{{ name }}/src/uvma_{{ name }}_tdefs.sv",
    "agent_advanced_serial/agent/gitignore"                       : "uvma_{{ name }}/.gitignore",
    "agent_advanced_serial/agent/ip.yml"                          : "uvma_{{ name }}/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                         : "uvma_{{ name }}/LICENSE.md",
    "agent_advanced_serial/agent/README.md"                       : "uvma_{{ name }}/README.md"
}

env_files = {
    #"agent_advanced_serial/env/bin/package.py"                    : "uvme_{{ name }}_st/bin/package.py",
    #"agent_advanced_serial/env/docs/env_block_diagram.svg"        : "uvme_{{ name }}_st/docs/env_block_diagram.svg",
    "agent_advanced_serial/env/examples/virtual_sequence.sv"      : "uvme_{{ name }}_st/examples/virtual_sequence.sv",
    "agent_advanced_serial/env/src/comps/cov_model.sv"            : "uvme_{{ name }}_st/src/comps/uvme_{{ name }}_st_cov_model.sv",
    "agent_advanced_serial/env/src/comps/env.sv"                  : "uvme_{{ name }}_st/src/comps/uvme_{{ name }}_st_env.sv",
    "agent_advanced_serial/env/src/comps/prd.sv"                  : "uvme_{{ name }}_st/src/comps/uvme_{{ name }}_st_prd.sv",
    "agent_advanced_serial/env/src/comps/sb.sv"                   : "uvme_{{ name }}_st/src/comps/uvme_{{ name }}_st_sb.sv",
    "agent_advanced_serial/env/src/comps/vsqr.sv"                 : "uvme_{{ name }}_st/src/comps/uvme_{{ name }}_st_vsqr.sv",
    "agent_advanced_serial/env/src/obj/cfg.sv"                    : "uvme_{{ name }}_st/src/obj/uvme_{{ name }}_st_cfg.sv",
    "agent_advanced_serial/env/src/obj/cntxt.sv"                  : "uvme_{{ name }}_st/src/obj/uvme_{{ name }}_st_cntxt.sv",
    "agent_advanced_serial/env/src/seq/base_vseq.sv"              : "uvme_{{ name }}_st/src/seq/uvme_{{ name }}_st_base_vseq.sv",
    "agent_advanced_serial/env/src/seq/rand_stim_vseq.sv"         : "uvme_{{ name }}_st/src/seq/uvme_{{ name }}_st_rand_stim_vseq.sv",
    "agent_advanced_serial/env/src/seq/vseq_lib.sv"               : "uvme_{{ name }}_st/src/seq/uvme_{{ name }}_st_vseq_lib.sv",
    "agent_advanced_serial/env/src/chkr.sv"                       : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_chkr.sv",
    "agent_advanced_serial/env/src/constants.sv"                  : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_constants.sv",
    "agent_advanced_serial/env/src/macros.svh"                    : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_macros.svh",
    "agent_advanced_serial/env/src/pkg.flist"                     : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_pkg.flist",
    "agent_advanced_serial/env/src/pkg.flist.xsim"                : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_pkg.flist.xsim",
    "agent_advanced_serial/env/src/pkg.sv"                        : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_pkg.sv",
    "agent_advanced_serial/env/src/tdefs.sv"                      : "uvme_{{ name }}_st/src/uvme_{{ name }}_st_tdefs.sv",
    "agent_advanced_serial/env/gitignore"                         : "uvme_{{ name }}_st/.gitignore",
    "agent_advanced_serial/env/ip.yml"                            : "uvme_{{ name }}_st/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                         : "uvme_{{ name }}_st/LICENSE.md",
    "agent_advanced_serial/env/README.md"                         : "uvme_{{ name }}_st/README.md"
}

tb_files = {
    #"agent_advanced_serial/tb/bin/package.py"                     : "uvmt_{{ name }}_st/bin/package.py",
    #"agent_advanced_serial/tb/docs/tb_block_diagram.svg"          : "uvmt_{{ name }}_st/docs/tb_block_diagram.svg",
    "agent_advanced_serial/tb/examples/test.sv"                   : "uvmt_{{ name }}_st/examples/test.sv",
    "agent_advanced_serial/tb/src/tb/clknrst_gen_if.sv"           : "uvmt_{{ name }}_st/src/tb/uvmt_{{ name }}_st_clknrst_gen_if.sv",
    "agent_advanced_serial/tb/src/tb/dut_chkr.sv"                 : "uvmt_{{ name }}_st/src/tb/uvmt_{{ name }}_st_dut_chkr.sv",
    "agent_advanced_serial/tb/src/tb/dut_wrap.sv"                 : "uvmt_{{ name }}_st/src/tb/uvmt_{{ name }}_st_dut_wrap.sv",
    "agent_advanced_serial/tb/src/tb/tb.sv"                       : "uvmt_{{ name }}_st/src/tb/uvmt_{{ name }}_st_tb.sv",
    "agent_advanced_serial/tb/src/tests/base_test_workarounds.sv" : "uvmt_{{ name }}_st/src/tests/uvmt_{{ name }}_st_base_test_workarounds.sv",
    "agent_advanced_serial/tb/src/tests/base_test.sv"             : "uvmt_{{ name }}_st/src/tests/uvmt_{{ name }}_st_base_test.sv",
    "agent_advanced_serial/tb/src/tests/rand_stim_test.sv"        : "uvmt_{{ name }}_st/src/tests/uvmt_{{ name }}_st_rand_stim_test.sv",
    "agent_advanced_serial/tb/src/tests/test_cfg.sv"              : "uvmt_{{ name }}_st/src/tests/uvmt_{{ name }}_st_test_cfg.sv",
    "agent_advanced_serial/tb/src/constants.sv"                   : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_constants.sv",
    "agent_advanced_serial/tb/src/macros.svh"                     : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_macros.svh",
    "agent_advanced_serial/tb/src/pkg.flist"                      : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_pkg.flist",
    "agent_advanced_serial/tb/src/pkg.flist.xsim"                 : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_pkg.flist.xsim",
    "agent_advanced_serial/tb/src/pkg.sv"                         : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_pkg.sv",
    "agent_advanced_serial/tb/src/tdefs.sv"                       : "uvmt_{{ name }}_st/src/uvmt_{{ name }}_st_tdefs.sv",
    "agent_advanced_serial/tb/gitignore"                          : "uvmt_{{ name }}_st/.gitignore",
    "agent_advanced_serial/tb/ip.yml"                             : "uvmt_{{ name }}_st/ip.yml",
    #"LICENSE_solderpad_v2p1.md"                         : "uvmt_{{ name }}_st/LICENSE.md",
    #"agent_advanced_serial/tb/README.md"                          : "uvmt_{{ name }}_st/README.md"
}

directories = [
    "uvma_{{ name }}",
    "uvma_{{ name }}/bin",
    "uvma_{{ name }}/docs",
    "uvma_{{ name }}/examples",
    "uvma_{{ name }}/src",
    "uvma_{{ name }}/src/comps",
    "uvma_{{ name }}/src/obj",
    "uvma_{{ name }}/src/seq",
    "uvme_{{ name }}_st",
    "uvme_{{ name }}_st/bin",
    "uvme_{{ name }}_st/docs",
    "uvme_{{ name }}_st/examples",
    "uvme_{{ name }}_st/src",
    "uvme_{{ name }}_st/src/comps",
    "uvme_{{ name }}_st/src/obj",
    "uvme_{{ name }}_st/src/seq",
    "uvmt_{{ name }}_st",
    "uvmt_{{ name }}_st/bin",
    "uvmt_{{ name }}_st/docs",
    "uvmt_{{ name }}_st/examples",
    "uvmt_{{ name }}_st/src",
    "uvmt_{{ name }}_st/src/tb",
    "uvmt_{{ name }}_st/src/tests"
]


########################################################################################################################
# MAIN
########################################################################################################################
def combine_dict(d1, d2):
    d3 = {}
    for d in d1:
        d3[d] = d1[d]
    for d in d2:
        d3[d] = d2[d]
    return d3


def process_file(path, file_path_template):
    global parameters
    if dbg:
        print("Processing file " + path + " with path template " + file_path_template)
    
    fin = open(relative_path_to_template + path, "rt")
    fout_path_template = Template(file_path_template)
    fout_path = fout_path_template.render(parameters)
    fout_path = out_path + "/" + fout_path
    if dbg:
        print("Templated path: " + fout_path)
    fout = open(fout_path, "w+")
    data = fin.read()
    template = Template(data)
    data = template.render(parameters)
    fin.close()
    print("Writing " + fout_path)
    fout.write(data)
    fout.close()


def process_all_files():
    global parameters
    final_fileset = combine_dict(env_files, tb_files)
    if parameters['symmetric']:
        final_fileset = combine_dict(final_fileset, symmetric_phy_agent_files)
    else:
        final_fileset = combine_dict(final_fileset, asymmetric_phy_agent_files)
    for file in final_fileset:
        process_file(file, final_fileset[file])


def create_directories():
    global parameters
    for dir in directories:
        dir_name = out_path + "/" + dir
        dir_name_template = Template(dir_name)
        dir_name = dir_name_template.render(parameters)
        if dbg:
            print("Creating directory '" + dir_name + "'")
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
    global full_name
    global name_of_copyright_owner
    global default_copyright_owner
    global parameters
    
    print("Moore.io Template Generator: UVM Advanced Serial Agent - (v1p0)")
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
    
    license = input("Please enter a usage license or hit RETURN for the default (default is '" + default_license + "'):\n").strip()
    if license == "":
        license = default_license
    
    name = input("Please enter the package name for this agent (ex: 'spi'); this name will be used for all agent types (ex: 'uvma_spi_agent_c'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    
    full_name = input("Please enter the full name for this agent (ex: 'Serial Peripheral Interface'):\n").strip()
    if full_name == "":
        sys.exit("ERROR: full name cannot be empty.  Exiting.")
    
    is_symmetric_str = input("Is the physical interface symmetric?  [N/y]").strip().lower()
    if is_symmetric_str == "":
        is_symmetric = False
    else:
        if is_symmetric_str == "n" or is_symmetric_str == "no":
            is_symmetric = False
        elif is_symmetric_str == "y" or is_symmetric_str == "yes":
            is_symmetric = True
        else:
            sys.exit("ERROR: please enter 'y' or 'n'")
    
    is_ddr_str = input("Is the physical interface using DDR clocking?  [N/y]").strip().lower()
    if is_ddr_str == "":
        is_ddr = False
    else:
        if is_ddr_str == "n" or is_ddr_str == "no":
            is_ddr = False
        elif is_ddr_str == "y" or is_ddr_str == "yes":
            is_ddr = True
        else:
            sys.exit("ERROR: please enter 'y' or 'n'")
    
    mode_1 = input("Please enter the first mode for this new agent (default: 'mstr'):\n").strip()
    if mode_1 == "":
        mode_1 = "mstr"
    
    mode_2 = input("Please enter the second mode for this new agent (default: 'slv'):\n").strip()
    if mode_2 == "":
        mode_2 = "slv"
    
    tx_str = input("Please enter the first direction for this new agent (default: 'm2s'):\n").strip()
    if tx_str == "":
        tx_str = "m2s"
    
    rx_str = input("Please enter the second direction for this new agent (default: 's2m'):\n").strip()
    if rx_str == "":
        rx_str = "s2m"
    
    parameters = {
        "name"                    : name,
        "full_name"               : full_name,
        "name_of_copyright_owner" : name_of_copyright_owner,
        "license"                 : license,
        "year"                    : date.today().year,
        "symmetric"               : is_symmetric,
        "ddr"                     : is_ddr,
        "mode_1"                  : mode_1,
        "mode_2"                  : mode_2,
        "tx"                      : tx_str,
        "rx"                      : rx_str
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

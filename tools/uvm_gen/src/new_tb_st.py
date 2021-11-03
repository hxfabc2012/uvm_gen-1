#!/usr/bin/python3
########################################################################################################################
# Copyright 2021 Datum Technology Corporation
########################################################################################################################
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################
# Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
# with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
#                                       https://solderpad.org/licenses/SHL-2.1/
# Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
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
relative_path_to_template = os.getcwd() + "/templates/tb_st/"
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
    "bin/package.py"                     : "uvmt_${name}_st/bin/package.py",
    "docs/tb_block_diagram.svg"          : "uvmt_${name}_st/docs/tb_block_diagram.svg",
    "examples/test.sv"                   : "uvmt_${name}_st/examples/test.sv",
    "src/tb/clknrst_gen_if.sv"           : "uvmt_${name}_st/src/tb/uvmt_${name}_st_clknrst_gen_if.sv",
    "src/tb/dut_chkr.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_chkr.sv",
    "src/tb/dut_wrap.sv"                 : "uvmt_${name}_st/src/tb/uvmt_${name}_st_dut_wrap.sv",
    "src/tb/tb.sv"                       : "uvmt_${name}_st/src/tb/uvmt_${name}_st_tb.sv",
    "src/tests/base_test_workarounds.sv" : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test_workarounds.sv",
    "src/tests/base_test.sv"             : "uvmt_${name}_st/src/tests/uvmt_${name}_st_base_test.sv",
    "src/tests/test_cfg.sv"              : "uvmt_${name}_st/src/tests/uvmt_${name}_st_test_cfg.sv",
    "src/constants.sv"                   : "uvmt_${name}_st/src/uvmt_${name}_st_constants.sv",
    "src/macros.sv"                      : "uvmt_${name}_st/src/uvmt_${name}_st_macros.sv",
    "src/pkg.flist"                      : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist",
    "src/pkg.flist.xsim"                 : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.flist.xsim",
    "src/pkg.sv"                         : "uvmt_${name}_st/src/uvmt_${name}_st_pkg.sv",
    "src/tdefs.sv"                       : "uvmt_${name}_st/src/uvmt_${name}_st_tdefs.sv",
    ".gitignore"                         : "uvmt_${name}_st/.gitignore",
    "ip.yml"                             : "uvmt_${name}_st/ip.yml",
    "../LICENSE_solderpad_v2p1.md"       : "uvmt_${name}_st/LICENSE.md",
    "README.md"                          : "uvmt_${name}_st/README.md"
}

directories = [
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
    
    print("Moore.io Template Generator: Self-Test Bench and UVM Test Library (v1p0)")
    print("***********************************************************************")
    print("The answers to the following questionnaire will be used to generate the code for your new UVM Test Bench")
    print("")
    
    if out_path == "":
        out_path = input("Please enter the destination path for this new agent (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "name"          : name,
        "name_uppercase": name.upper(),
        "year"          : date.today().year
    }
    
    name_of_copyright_owner = input("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = input("Please enter the name of the Agent/Library for this Self-Test Bench (ex: 'apb'); this name will be used for all Test Bench types (ex: 'uvmt_apb_st_tb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this Agent/Library (ex: 'Advanced Peripheral Bus (APB)'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    name_1 = input("Please enter the name for the first agent instance (default: 'mstr'):\n").strip()
    if name_1 == "":
        parameters["name_1"] = "mstr"
    else:
        parameters["name_1"] = name_1
    
    name_2 = input("Please enter the name for the second agent instance (default: 'slv'):\n").strip()
    if name_2 == "":
        parameters["name_2"] = "slv"
    else:
        parameters["name_2"] = name_2


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()

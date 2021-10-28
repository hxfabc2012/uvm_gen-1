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
relative_path_to_template = os.getcwd() + "/templates/tb_ss/"
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
    "bin/package.py"                     : "uvmt_${name}/bin/package.py",
    "docs/tb_block_diagram.svg"          : "uvmt_${name}/docs/tb_block_diagram.svg",
    "examples/test.sv"                   : "uvmt_${name}/examples/test.sv",
    "src/tb/probe_if.sv"                 : "uvmt_${name}/src/tb/uvmt_${name}_probe_if.sv",
    "src/tb/dut_chkr.sv"                 : "uvmt_${name}/src/tb/uvmt_${name}_dut_chkr.sv",
    "src/tb/dut_wrap.sv"                 : "uvmt_${name}/src/tb/uvmt_${name}_dut_wrap.sv",
    "src/tb/tb.sv"                       : "uvmt_${name}/src/tb/uvmt_${name}_tb.sv",
    "src/tests/reg_base_test.sv"         : "uvmt_${name}/src/tests/uvmt_${name}_reg_base_test.sv",
    "src/tests/reg_bit_bash_test.sv"     : "uvmt_${name}/src/tests/uvmt_${name}_reg_bit_bash_test.sv",
    "src/tests/reg_hw_reset_test.sv"     : "uvmt_${name}/src/tests/uvmt_${name}_reg_hw_reset_test.sv",
    "src/tests/base_test_workarounds.sv" : "uvmt_${name}/src/tests/uvmt_${name}_base_test_workarounds.sv",
    "src/tests/base_test.sv"             : "uvmt_${name}/src/tests/uvmt_${name}_base_test.sv",
    "src/tests/test_cfg.sv"              : "uvmt_${name}/src/tests/uvmt_${name}_test_cfg.sv",
    "src/constants.sv"                   : "uvmt_${name}/src/uvmt_${name}_constants.sv",
    "src/macros.sv"                      : "uvmt_${name}/src/uvmt_${name}_macros.sv",
    "src/pkg.flist"                      : "uvmt_${name}/src/uvmt_${name}_pkg.flist",
    "src/pkg.flist.xsim"                 : "uvmt_${name}/src/uvmt_${name}_pkg.flist.xsim",
    "src/pkg.sv"                         : "uvmt_${name}/src/uvmt_${name}_pkg.sv",
    "src/tdefs.sv"                       : "uvmt_${name}/src/uvmt_${name}_tdefs.sv",
    "../.gitignore"                      : "uvmt_${name}/.gitignore",
    "../LICENSE_solderpad_v2p1.md"       : "uvmt_${name}/LICENSE.md",
    "README.md"                          : "uvmt_${name}/README.md"
}

directories = [
    "uvmt_${name}",
    "uvmt_${name}/bin",
    "uvmt_${name}/docs",
    "uvmt_${name}/examples",
    "uvmt_${name}/src",
    "uvmt_${name}/src/tb",
    "uvmt_${name}/src/tests"
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
    
    print("Moore.io Template Generator: Sub-System Test Bench and UVM Test Library (v1p0)")
    print("******************************************************************************")
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
    
    name = input("Please enter the package name for this Test Bench (ex: 'dp'); this name will be used for all Test Bench types (ex: 'uvmt_dp_tb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    name_normal_case = input("Please enter the (descriptive) name for this Test Bench (ex: 'Data Plane'):\n").strip()
    if name_normal_case == "":
        sys.exit("ERROR: descriptive name cannot be empty.  Exiting.")
    else:
        parameters["name_normal_case"] = name_normal_case
    
    clk_agent_name = input("Please enter the type for the Clock Agent (default: 'clk'):\n").strip()
    if clk_agent_name == "":
        parameters["clk_agent_type"] = "clk"
        parameters["clk_agent_type_uppercase"] = "CLK"
    else:
        parameters["clk_agent_type"] = clk_agent_name
        parameters["clk_agent_type_uppercase"] = clk_agent_name.upper()
    
    clk_agent_name = input("Please enter the name of the Clock Agent (default: 'sys_clk'):\n").strip()
    if clk_agent_name == "":
        parameters["clk_agent_name"] = "sys_clk"
    else:
        parameters["clk_agent_name"] = clk_agent_name
    
    reset_agent_name = input("Please enter the type for the Reset Agent (default: 'reset'):\n").strip()
    if reset_agent_name == "":
        parameters["reset_agent_type"] = "reset"
        parameters["reset_agent_type_uppercase"] = "RESET"
    else:
        parameters["reset_agent_type"] = reset_agent_name
        parameters["reset_agent_type_uppercase"] = reset_agent_name.upper()
    
    reset_agent_name = input("Please enter the name of the Reset Agent (default: 'sys_reset'):\n").strip()
    if reset_agent_name == "":
        parameters["reset_agent_name"] = "sys_reset"
    else:
        parameters["reset_agent_name"] = reset_agent_name
    
    ral_agent_type = input("Please enter the type for the RAL Agent (default: 'axil'):\n").strip()
    if ral_agent_type == "":
        parameters["ral_agent_type"] = "axil"
        parameters["ral_agent_type_uppercase"] = "AXIL"
    else:
        parameters["ral_agent_type"] = ral_agent_type
        parameters["ral_agent_type_uppercase"] = ral_agent_type.upper()
    
    ral_agent_name = input("Please enter the name of the RAL Agent (default: 'axil'):\n").strip()
    if ral_agent_name == "":
        parameters["ral_agent_name"] = "axil"
    else:
        parameters["ral_agent_name"] = ral_agent_name


########################################################################################################################
# ENTRY POINT
########################################################################################################################
pick_out_path()
prompt_user_values()
create_directories()
process_all_files()
#!/usr/bin/python3
########################################################################################################################
# Copyright 2022 Datum Technology Corporation
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


"""Moore.io UVM Singleton Generator
   Generates single files of UVM code.
   
Usage:
   new.py component    [options]
   new.py object       [options]
   new.py reg_adapter  [options]
   new.py reg          [options]
   new.py reg_block    [options]
   new.py seq          [options]
   new.py seq_lib      [options]
   new.py test         [options]
   new.py vseq         [options]
   new.py vseq_lib     [options]

Options:
   -f <in_path>           Load questionnaire answers from file.
   -o <out_path>          Specify output path inline.
   -c <copyright_owner>   Load copyright owner name inline.
   -h --help              Show this screen
   --version              Show version.
   
Examples:
   new.py seq                                        # Create new sequence
   new.py component ~/my_proj/src                    # Create new component in specific directory
   new.py test      ~/my_proj/tb/tests/ 'Acme Inc.'  # Create new test in specific directory with default copyright holder"""


########################################################################################################################
# IMPORTS
########################################################################################################################
from datetime import date
import os
import sys
from docopt import docopt


########################################################################################################################
# GLOBALS
########################################################################################################################
dbg = False
args = {}
relative_path_to_template = os.getcwd() + "/templates/"
out_path = ""
default_copyright_owner = ""
name_of_copyright_owner = ""
name = ""
name_normal_case = ""
answers_file = None


########################################################################################################################
# TEMPLATE DATA
########################################################################################################################
files = {
    'component' : {
        'in' : 'component.sv',
        'out' : '${pkg_name}_${name}.sv'
    },
    'object' : {
        'in' : 'object.sv',
        'out' : '${pkg_name}_${name}.sv'
    },
    'reg_adapter' : {
        'in' : 'reg_adapter.sv',
        'out' : '${name}_reg_adapter.sv'
    },
    'reg_block' : {
        'in' : 'reg_block.sv',
        'out' : '${pkg_name}_${name}_reg_block.sv'
    },
    'reg' : {
        'in' : 'reg.sv',
        'out' : '${pkg_name}_${name}_reg.sv'
    },
    'seq_lib' : {
        'in' : 'seq_lib.sv',
        'out' : '${pkg_name}_${name}_seq_lib.sv'
    },
    'seq' : {
        'in' : 'seq.sv',
        'out' : '${pkg_name}_${name}_seq.sv'
    },
    'test' : {
        'in' : 'test.sv',
        'out' : 'uvmt_${tb_name}_${name}_test.sv'
    },
    'vseq_lib' : {
        'in' : 'vseq_lib.sv',
        'out' : '${pkg_name}_${name}_vseq_lib.sv'
    },
    'vseq' : {
        'in' : 'vseq.sv',
        'out' : '${pkg_name}_${name}_vseq.sv'
    }
}


########################################################################################################################
# MAIN
########################################################################################################################
def process_file(parameters, path, file_path_template):
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

def pick_out_path():
    global args
    global out_path
    global default_copyright_owner
    if (args['-o']):
        out_path = args['-o']
        print("Code will be output to " + out_path)
    if (args['-c']):
        default_copyright_owner = args['<copyright_owner>']
        print("Default copyright owner is " + default_copyright_owner)
        

def get_next_answer(question):
    global args
    global answers_file
    if args['-f']:
        return answers_file.readline()
    else:
        return input(question)

def gen_component():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Component (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Component (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Component (ex: 'my_comp'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Component (ex: 'uvma_apb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Component (default: 'uvm_component'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_component"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['component']['in'], files['component']['out'])

def gen_object():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Object (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Object (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Object (ex: 'my_obj'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Object (ex: 'uvma_apb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Object (default: 'uvm_object'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_object"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['object']['in'], files['object']['out'])

def gen_reg_adapter():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Register Adapter (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Register Adapter (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the package name for this Register Adapter (ex: 'uvma_apb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Register Adapter (default: 'uvm_reg_adapter'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_reg_adapter"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['reg_adapter']['in'], files['reg_adapter']['out'])

def gen_reg_block():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Register Block (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Register Block (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Register Block (ex: 'top'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Register Block (ex: 'uvme_my_ss'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Register Block (default: 'uvm_reg_block'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_reg_block"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['reg_block']['in'], files['reg_block']['out'])

def gen_reg():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Register (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Register (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Register (ex: 'status'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Register (ex: 'uvme_my_ss'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Register (default: 'uvm_reg'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_reg"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['reg']['in'], files['reg']['out'])

def gen_seq():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Sequence (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Sequence (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Sequence (ex: 'traffic'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Sequence (ex: 'uvma_apb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Sequence (ex: 'uvma_apb_base_seq_c'):\n").lower().strip()
    if base_class == "":
        sys.exit("ERROR: base class type cannot be empty.  Exiting.")
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['seq']['in'], files['seq']['out'])

def gen_seq_lib():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Sequence Library (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Sequence Library (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Sequence Library (ex: 'mstr'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Sequence Library (ex: 'uvma_apb'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Sequence Library (ex: 'uvm_sequence_library #(uvm_sequence_item)'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_sequence_library #(uvm_sequence_item)"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['seq_lib']['in'], files['seq_lib']['out'])

def gen_test():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Test (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Test (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Test (ex: 'smoke'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    vseq_name = get_next_answer("Please enter the Virtual Sequence name for this Test (ex: 'basic_access'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["vseq_name"] = vseq_name
    
    pkg_name = get_next_answer("Please enter the package name for this Test (ex: 'my_ss'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["tb_name"] = pkg_name
        parameters["tb_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Test (ex: 'uvm_test'):\n").lower().strip()
    if base_class == "":
        sys.exit("ERROR: base class type cannot be empty.  Exiting.")
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['test']['in'], files['test']['out'])

def gen_vseq():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Virtual Sequence (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Virtual Sequence (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Virtual Sequence (ex: 'basic_access'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Virtual Sequence (ex: 'uvme_my_ss'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Virtual Sequence (ex: 'uvme_my_ss_base_vseq_c'):\n").lower().strip()
    if base_class == "":
        sys.exit("ERROR: base class type cannot be empty.  Exiting.")
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['vseq']['in'], files['vseq']['out'])

def gen_vseq_lib():
    global out_path
    global default_copyright_owner
    parameters = {}
    print("Moore.io Template Generator: Virtual Sequence Library (v1p0)")
    
    if out_path == "":
        out_path = get_next_answer("Please enter the destination path for this new Virtual Sequence Library (default: '.'):\n").strip()
        if out_path == "":
            out_path = "."
    
    parameters = {
        "year" : date.today().year
    }
    
    name_of_copyright_owner = get_next_answer("Please enter a specific name for the copyright holder or hit RETURN for the default (default is '" + default_copyright_owner + "'):\n").strip()
    if name_of_copyright_owner == "":
        name_of_copyright_owner = default_copyright_owner
    parameters["name_of_copyright_owner"] = name_of_copyright_owner
    
    name = get_next_answer("Please enter the name for this Virtual Sequence Library (ex: 'cpu'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: name cannot be empty.  Exiting.")
    else:
        parameters["name"] = name
        parameters["name_uppercase"] = name.upper()
    
    pkg_name = get_next_answer("Please enter the package name for this Virtual Sequence Library (ex: 'uvme_my_ss'):\n").lower().strip()
    if name == "":
        sys.exit("ERROR: package name cannot be empty.  Exiting.")
    else:
        parameters["pkg_name"] = pkg_name
        parameters["pkg_name_uppercase"] = pkg_name.upper()
    
    base_class = get_next_answer("Please enter the base class type for this Virtual Sequence Library (ex: 'uvm_sequence_library #(uvm_sequence_item)'):\n").lower().strip()
    if base_class == "":
        parameters["base_class"] = "uvm_sequence_library #(uvm_sequence_item)"
    else:
        parameters["base_class"] = base_class
    
    process_file(parameters, files['vseq_lib']['in'], files['vseq_lib']['out'])


########################################################################################################################
# ENTRY POINT
########################################################################################################################
if __name__ == '__main__':
    args = docopt(__doc__, version='Moore.io UVM Singleton Generator v1.0 Beta 0')
    
    if args['-f']:
        answers_file = open(args['-f'], "rt")
    
    pick_out_path()
    
    if (args['component']):
        gen_component()
    
    if (args['object']):
        gen_object()
    
    if (args['reg_adapter']):
        gen_reg_adapter()
    
    if (args['reg']):
        gen_reg()
    
    if (args['reg_block']):
        gen_reg_block()
    
    if (args['seq']):
        gen_seq()
    
    if (args['seq_lib']):
        gen_seq_lib()
    
    if (args['test']):
        gen_test()
    
    if (args['vseq']):
        gen_vseq()
    
    if (args['vseq_lib']):
        gen_vseq_lib()


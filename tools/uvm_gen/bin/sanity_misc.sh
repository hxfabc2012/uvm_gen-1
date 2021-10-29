#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
########################################################################################################################
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
## Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
## with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
##                                        https://solderpad.org/licenses/SHL-2.1/
## Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
## an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
## specific language governing permissions and limitations under the License.
########################################################################################################################


# 1. Create code from spec files
#cat ./tests/lib.spec         | ./src/new_library.py ../../dv/
cat ./tests/component.spec   | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/object.spec      | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/reg_adapter.spec | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/reg.spec         | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/reg_block.spec   | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/seq.spec         | ./src/new.py         ../../dv/uvmt_misc_st/src/seq
#cat ./tests/seq_lib.spec     | ./src/new.py         ../../dv/uvmt_misc_st/src/seq
#cat ./tests/test.spec        | ./src/new.py         ../../dv/uvmt_misc_st/src/tests
#cat ./tests/vseq.spec        | ./src/new.py         ../../dv/uvmt_misc_st/src/seq
#cat ./tests/vseq_lib.spec    | ./src/new.py         ../../dv/uvmt_misc_st/src/seq

# 2. Simulate
#cd ../../sim
#./setup_project.py
#source ./setup_terminal.sh
#dvm all uvmt_misc_st -t smoke -s 1

# 3. Gather sim results
#../tools/dvm/src/dvm.py results uvmt_misc_st misc

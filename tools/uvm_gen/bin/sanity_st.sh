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
cat ./tests/agent.spec  | ./src/new_agent_simplex_no_layers.py ../../dv/
cat ./tests/env_st.spec | ./src/new_env_st.py                  ../../dv/
cat ./tests/tb_st.spec  | ./src/new_tb_st.py                   ../../dv/

# 2. Simulate
cd ../../sim
./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/mio.py cpel uvmt_abc_st
../tools/.imports/mio/mio.py sim  uvmt_abc_st -t base -s 1

# 3. Gather sim results
../tools/.imports/mio/mio.py results uvmt_abc_st tb_st

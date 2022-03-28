#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
########################################################################################################################
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# 1. Generate code
cat ./tests/agent_basic.spec | ./src/new_agent_basic.py  ../../dv/

# 2. Simulate
cd ../../sim
./setup_project.py
source ./setup_terminal.sh
../tools/.imports/mio/src/mio.py cpel uvmt_abc_st
../tools/.imports/mio/src/mio.py sim  uvmt_abc_st -t base -s 1

# 3. Gather sim results
../tools/.imports/mio/src/mio.py results uvmt_abc_st tb_st

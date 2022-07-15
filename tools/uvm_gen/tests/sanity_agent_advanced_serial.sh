#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved
########################################################################################################################


# 0. Remove old code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 1. Generate code
cat ./tests/data/agent_advanced_serial.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 2. Simulate
#cd ../../sim
#./setup_project.py
#source ./setup_terminal.sh
#../tools/.imports/mio/src/__main__.py cpel uvmt_xyz_st
#../tools/.imports/mio/src/__main__.py sim  uvmt_xyz_st -t rand_stim -s 1

# 3. Gather sim results
#../tools/.imports/mio/src/__main__.py results uvmt_xyz_st tb_st

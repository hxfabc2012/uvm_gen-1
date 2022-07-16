#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 1. Generate code
cat ./tests/data/agent_advanced_serial.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 2. Simulate
cd ../../sim
#mio install uvmt_bsb_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_bsb_st
#mio cpel uvmt_bsb_st
#mio sim  uvmt_bsb_st -t rand_stim -s 1

# 3. Gather sim results
#mio results uvmt_bsb_st advanced_agent_serial

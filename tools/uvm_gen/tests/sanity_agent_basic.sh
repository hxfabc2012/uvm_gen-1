#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_abc ../../dv/uvme_abc_st ../../dv/uvmt_abc_st

# 1. Generate code
cat ./tests/data/agent_basic.spec | ./src/new_agent_basic.py  ../../dv

# 2. Simulate
cd ../../sim
mio install uvmt_abc_st -u admin -p Qc5SgRpk6cjsAjr
mio cpel uvmt_abc_st
mio sim  uvmt_abc_st -t rand_stim -s 1

# 3. Gather sim results
mio results uvmt_abc_st basic_agent

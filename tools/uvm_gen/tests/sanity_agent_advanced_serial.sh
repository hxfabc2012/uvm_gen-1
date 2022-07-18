#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_aas0 ../../dv/uvme_aas0_st ../../dv/uvmt_aas0_st

# 1. Generate asymmetric SDR code
cat ./tests/data/agent_advanced_serial_0.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 2. Simulate asymmetric SDR code
cd ../../sim
mio install uvmt_aas0_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_aas0_st
mio elab uvmt_aas0_st
mio sim  uvmt_aas0_st -t rand_stim -s 1 -v medium -w -c
mio cov  uvmt_aas0_st
cd ../tools/uvm_gen


# 3. Remove asymmetric SDR code
rm -rf ../../dv/uvma_aas1 ../../dv/uvme_aas1_st ../../dv/uvmt_aas1_st

# 4. Generate symmetric SDR code
cat ./tests/data/agent_advanced_serial_1.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 5. Simulate symmetric SDR code
cd ../../sim
mio install uvmt_aas1_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_aas1_st
mio elab uvmt_aas1_st
mio sim  uvmt_aas1_st -t rand_stim -s 1 -v medium -w -c
mio cov  uvmt_aas1_st
cd ../tools/uvm_gen


# 6. Remove symmetric SDR code
rm -rf ../../dv/uvma_aas2 ../../dv/uvme_aas2_st ../../dv/uvmt_aas2_st

# 7. Generate asymmetric DDR code
cat ./tests/data/agent_advanced_serial_2.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 8. Simulate asymmetric DDR code
cd ../../sim
mio install uvmt_aas2_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_aas2_st
mio elab uvmt_aas2_st
mio sim  uvmt_aas2_st -t rand_stim -s 1 -v medium -w -c
mio cov  uvmt_aas2_st
cd ../tools/uvm_gen


# 9. Remove asymmetric DDR code
rm -rf ../../dv/uvma_aas3 ../../dv/uvme_aas_st ../../dv/uvmt_aas3_st

# 10. Generate symmetric DDR code
cat ./tests/data/agent_advanced_serial_3.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 11. Simulate symmetric DDR code
cd ../../sim
mio install uvmt_aas3_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_aas3_st
mio elab uvmt_aas3_st
mio sim  uvmt_aas3_st -t rand_stim -s 1 -v medium -w -c
mio cov  uvmt_aas3_st


# 12. Gather sim results
mio results uvmt_aas0_st advanced_agent_serial_0
mio results uvmt_aas1_st advanced_agent_serial_1
mio results uvmt_aas2_st advanced_agent_serial_2
mio results uvmt_aas3_st advanced_agent_serial_3

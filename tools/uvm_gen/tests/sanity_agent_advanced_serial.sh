#! /bin/bash
########################################################################################################################
## Copyright 2022 Datum Technology Corporation
## All rights reserved.
########################################################################################################################


shopt -s expand_aliases
source ~/.bashrc


# 0. Remove old code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 1. Generate asymmetric SDR code
cat ./tests/data/agent_advanced_serial_0.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 2. Simulate asymmetric SDR code
cd ../../sim
mio install uvmt_bsb_st -u admin -p Qc5SgRpk6cjsAjr
mio cmp  uvmt_bsb_st
mio elab uvmt_bsb_st
mio sim  uvmt_bsb_st -t rand_stim -s 1 -v medium -w -c
cd ../tools/uvm_gen


# 3. Remove asymmetric SDR code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 4. Generate symmetric SDR code
cat ./tests/data/agent_advanced_serial_1.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 5. Simulate symmetric SDR code
cd ../../sim
mio cmp  uvmt_bsb_st
mio elab uvmt_bsb_st
mio sim  uvmt_bsb_st -t rand_stim -s 2 -v medium -w -c
cd ../tools/uvm_gen


# 6. Remove symmetric SDR code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 7. Generate asymmetric DDR code
cat ./tests/data/agent_advanced_serial_2.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 8. Simulate asymmetric DDR code
cd ../../sim
mio cmp  uvmt_bsb_st
mio elab uvmt_bsb_st
mio sim  uvmt_bsb_st -t rand_stim -s 3 -v medium -w -c
cd ../tools/uvm_gen


# 9. Remove asymmetric DDR code
rm -rf ../../dv/uvma_bsb ../../dv/uvme_bsb_st ../../dv/uvmt_bsb_st

# 10. Generate symmetric DDR code
cat ./tests/data/agent_advanced_serial_3.spec | ./src/new_agent_advanced_serial.py  ../../dv

# 11. Simulate symmetric DDR code
cd ../../sim
mio cmp  uvmt_bsb_st
mio elab uvmt_bsb_st
mio sim  uvmt_bsb_st -t rand_stim -s 4 -v medium -w -c


# 12. Gather sim results
mio results uvmt_bsb_st advanced_agent_serial

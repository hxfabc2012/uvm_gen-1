# About
## [Home Page](https://datum-technology-corporation.github.io/uvm_gen/)
The Moore.io UVM Generator Suite is a complete set of code templates for any conceivable type of UVM construct one could want. From a test to chip-level environments and register model generation, The Mio UVM Generator Suite is a solid foundation upon which to build your digital design verification projects.  All templates are tested in Xilinx Vivado 2021.1 all the way through simulation.

## Available Generators/Templates

| Name | Script |
| ---- | --------- |
| Agent - Simplex, No Layers | `new_agent_simplex_no_layers.py` |
| Environment - Sub-System (SS) | `new_env_ss.py` |
| Environment - Self-Test (ST) | `new_env_st.py` |
| Library | `new_lib.py` |
| Test Bench - Sub-System (SS) | `new_tb_ss.py` |
| Test Bench - Self-Test (ST) | `new_tb_st.py` |

| Name | Script |
| ---- | --------- |
| Component | `new.py component` |
| Object | `new.py object` |
| Reg Adapter | `new.py reg_adapter` |
| Register | `new.py reg` |
| Register Block | `new.py reg_block` |
| Sequence | `new.py seq` |
| Sequence Library | `new.py seq_lib` |
| Test | `new.py test` |
| Virtual Sequence | `new.py vseq` |
| Virtual Sequence Library | `new.py vseq_lib` |


## IP
* DV
> * uvmt_misc_st
* RTL
* Tools
> * uvm_gen


# Generation
To run the "Agent - Simplex, no Layer" generator:

```
cd ./tools/uvm_gen
./src/new_agent_simplex_no_layers.py
```

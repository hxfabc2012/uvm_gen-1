# About
## [Home Page](https://datum-technology-corporation.github.io/uvm_gen/)
The Moore.io UVM Generator Suite is a complete set of code templates for any conceivable type of UVM construct one could want. From a test to chip-level environments and register model generation, The Mio UVM Generator Suite is a solid foundation upon which to build your digital design verification projects.

## IP
* DV
* RTL
* Tools
> * uvm_gen
> * uvm_gen_agent
> * uvm_gen_env
> * uvm_gen_lib
> * uvm_gen_tb


# Generation
**1. Change directory to the sub-generator**

This is from where all jobs will be launched.  For example, to generate from the Singleton group of generators:

```
cd ./tools/uvm_gen
```

or to generate from the Environment group of generators:

```
cd ./tools/uvm_gen_env
```


**2. Run Generator Script**

The python scripts are self-contained and are run via CLI (you will be prompted for parameter values).  For instance,
to run the "Agent - Simplex, no Layer" generator:

```
./src/new_agent_simplex_no_layers.py
```


**3. List tasks**

Templates leave behind `TODO` comments throughout the code, usually with examples, for the user to fill in.  Usually, templates will not simulate properly without these tasks being finished first:

```
grep -nr TODO ./uvma_apb > my_new_agent_tasks.txt
```


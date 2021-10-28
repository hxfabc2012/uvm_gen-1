# About
## [Home Page](https://datum-technology-corporation.github.io/uvm_gen/)
The Moore.io UVM Generator Suite is a complete set of code templates for any conceivable type of UVM construct one could want. From a test to chip-level environments and register model generation, The Mio UVM Generator Suite is a solid foundation upon which to build your digital design verification projects.

## IP
* DV
* RTL
* Tools
> * uvm_gen


# Generation
**1. Run Generator Script**

The python scripts are self-contained and are run via CLI (you will be prompted for parameter values).  For instance,
to run the "Agent - Simplex, no Layer" generator:

```
./src/new_agent_simplex_no_layers.py
```


**2. List tasks**

Templates leave behind `TODO` comments throughout the code, usually with examples, for the user to fill in.  Usually, templates will not simulate properly without these tasks being finished first:

```
grep -nr TODO ./uvma_apb > my_new_agent_tasks.txt
```


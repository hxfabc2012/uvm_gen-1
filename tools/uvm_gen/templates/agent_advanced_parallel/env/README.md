# {{ full_name }} ({{ upper(name) }}) UVM Agent Self-Test Environment

# About
This IP contains the {{ full_name }} ({{ upper(name) }}) UVM Agent Self-Test Environment.

# Block Diagram
![alt text](./docs/env_block_diagram.png "{{ full_name }} ({{ upper(name) }}) UVM Agent Self-Test Environment Block Diagram")

# Directory Structure
* `bin` - Scripts, metadata and other miscellaneous files
* `docs` - Documents describing the {{ full_name }} UVM Agent Self-Test Environment
* `examples` - Samples for users
* `src` - Source code for this IP


# Dependencies
It is dependent on the following packages:

* [`uvm_pkg`](https://www.accellera.org/downloads/standards/uvm)
* [`uvml_pkg`](https://datum-technology-corporation.github.io/uvml/)
* [`uvml_logs_pkg`](https://datum-technology-corporation.github.io/uvml_logs/)
* `uvml_mem_pkg`
* `uvma_{{ name }}`

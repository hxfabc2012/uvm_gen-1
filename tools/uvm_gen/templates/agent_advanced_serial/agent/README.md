# A Word From Your Code Generator
Thank you for using the Moore.io Advanced UVM Agent Code Template for Serial protocols v1.0!

Your parameters are:
* Name: '{{ name }}'
* Full Name: '{{ full_name }}'
* Mode 1: '{{ mode_1 }}'
* Mode 2: '{{ mode_2 }}'
* Direction 1: '{{ tx }}'
* Direction 2: '{{ rx }}'
* Clocking: {% if ddr %}DDR{% else %}SDR{% endif %}
* Interface Symmetry: {% if symmetric %}{{ tx.upper() }} and {{ rx.upper() }} are the same{% else %}{{ tx.upper() }} and {{ rx.upper() }} are NOT the same{% endif %}

If this is incorrect, it's recommended to delete the generated IP and re-generate with the correct parameters.

This code template is based on the ['Advanced' UVM methodology](https://www.linkedin.com/pulse/advanced-uvm-brian-hunter/).
This agent uses multiple sequencers and virtual sequences to harness the full power of UVM and elegantly implement serial
protocols.  It can also be combined with other Advanced UVM template instances to create VIP 'stacks'.

As opposed to most other Moore.io UVM code templates, this one has a protocol implemented out of the box.
This serial protocol is as simple as possible, while providing enough material to quickly get you angled towards your particular
protocol implementation challenges.  It has a simple "training sequence", an edge "syncing" stage which locks upon 36b
frames:  2b header/sync, 32b data, 2b tail.  There is error checking on the frame itself, but once a serial link is
synced, it does not lose sync again regardless of errors.

What follows is a short guide for developers of this new UVM Agent.

## 1. Modify the physical interface definitions
### 1.1 Physical Interface - `uvma_{{ name }}_if`
Modify the signals to match your protocol's physical interface.

{% if symmetric %}### 1.1 Phy Monitor Transaction - `uvma_{{ name }}_phy_mon_trn_c`
Modify the fields to match your interface definition.

### 1.2 Phy Sequence Item - `uvma_{{ name }}_phy_seq_item_c`
Modify the fields to match your interface definition.

### 1.3 Phy Driver - `uvma_{{ name }}_phy_drv_c`
Modify the code driving the modport signals to match your interface definition.

### 1.4 Phy Driver Virtual Sequence - `uvma_{{ name }}_{{ tx }}_phy_vseq_c`
Modify the sequence to match your interface definition.

### 1.5 Monitor - `uvma_{{ name }}_mon_c`
Modify the code sampling the modports signals to match your interface definition.

### 1.6 Monitor Virtual Sequence - `uvma_{{ name }}_mon_vseq_c`
Modify the code pushing data from Phy Monitor Transactions to match your new interface definition.

{% else %}### 1.1 {{ tx.upper() }} Phy Monitor Transaction - `uvma_{{ name }}_{{ tx }}_mon_trn_c`
Modify the fields to match your interface definition.

### 1.2 {{ rx.upper() }} Phy Monitor Transaction - `uvma_{{ name }}_{{ rx }}_mon_trn_c`
Modify the fields to match your interface definition.

### 1.3 {{ tx.upper() }} Phy Sequence Item - `uvma_{{ name }}_{{ tx }}_seq_item_c`
Modify the fields to match your interface definition.

### 1.4 {{ rx.upper() }} Phy Sequence Item - `uvma_{{ name }}_{{ rx }}_seq_item_c`
Modify the fields to match your interface definition.

### 1.5 {{ tx.upper() }} Phy Driver - `uvma_{{ name }}_{{ tx }}_drv_c`
Modify the code driving the modports signals to match your interface definition.

### 1.6 {{ rx.upper() }} Phy Driver - `uvma_{{ name }}_{{ rx }}_drv_c`
Modify the code driving the modports signals to match your interface definition.

### 1.7 {{ tx.upper() }} Phy Driver Virtual Sequence - `uvma_{{ name }}_{{ tx }}_drv_vseq_c`
Modify the code to match your interface definition.

### 1.8 {{ rx.upper() }} Phy Driver Virtual Sequence - `uvma_{{ name }}_{{ rx }}_drv_vseq_c`
Modify the code to match your interface definition.

### 1.9 Monitor - `uvma_{{ name }}_mon_c`
Modify the code sampling the modports signals to match your interface definition.

### 1.10 Monitor Virtual Sequence - `uvma_{{ name }}_mon_vseq_c`
Modify the code pushing data from Phy Monitor Transactions to match your new interface definition.

{% endif %}
## 2. Logical Transaction Model
### 2.1 Sequence Item - `uvma_{{ name }}_seq_item_c`
Modify the fields to model your protocol frame structure for stimulus generation.

### 2.2 Monitor Transaction - `uvma_{{ name }}_mon_trn_c`
Modify the fields to model your protocol frame structure for rebuilding from sampled data.

## 3. Protocol Implementation
### 2.1 Configuration - `uvma_{{ name }}_cfg_c`
Add parameters if needed to present the user with protocol options.

### 2.1 FSM Definition - `uvma_{{ name }}_mon_fsm_cntxt_c`
Add fields and modify types if needed to store the Monitor Finite State Machine (FSM) data.

### 2.2 Monitor FSM - `uvma_{{ name }}_mon_vseq_c`
Modify the code to implement your protocol's serial FSM.

### 2.2 IDLE Generation - `uvma_{{ name }}_idle_vseq_c`
Modify the sequence to implement IDLE generation for your protocol.

## That's it!
The codebase is ready to roll alongside the other 2 IPs generated alongside this Agent:
* `uvme_{{ name }}_st`
* `uvmt_{{name }}_st`




# {{ name_of_copyright_owner }} ({{ name.upper() }}) UVM Agent

# About
This IP contains the {{ name_of_copyright_owner }} {{ full_name }} UVM Agent.
TODO Describe {{ full_name }} UVM Agent

# Block Diagram
![alt text](./docs/agent_block_diagram.png "{{ full_name }} UVM Agent Block Diagram")

# Directory Structure
* `bin` - Scripts, metadata and other miscellaneous files
* `docs` - Documents describing the {{ full_name }} UVM Agent
* `examples` - Code samples for using and extending this agent
* `src` - Source code


# Dependencies
It IP is dependent on the following packages:

* `uvm_pkg`
* `uvml_pkg`
* `uvml_logs_pkg`
* `uvml_mem_pkg`

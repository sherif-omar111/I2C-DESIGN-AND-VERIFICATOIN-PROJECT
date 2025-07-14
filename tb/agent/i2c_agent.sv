`ifndef I2C_AGENT_SV
    `define I2C_AGENT_SV

class i2c_agent extends uvm_agent;

//Driver handler
i2c_driver driver;

//Sequencer handler
i2c_sequencer sequencer;

//Monitor handler
i2c_monitor monitor;

`uvm_component_utils(i2c_agent)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase (phase);

    driver      = i2c_driver::type_id::create("driver", this);
    sequencer   = i2c_sequencer::type_id::create("sequencer", this);
    monitor     = i2c_monitor::type_id::create("monitor", this);

endfunction

virtual function void connect_phase (uvm_phase phase);

    super.connect_phase(phase);
    `uvm_info("DEBUG", $sformatf("Hello from i2c agent connect phase"), UVM_NONE)

    driver.seq_item_port.connect(sequencer.seq_item_export);

    endfunction
    
endclass

`endif 


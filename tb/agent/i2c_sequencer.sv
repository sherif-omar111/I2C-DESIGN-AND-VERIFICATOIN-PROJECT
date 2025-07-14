`ifndef I2C_SEQUENCER_SV
    `define I2C_SEQUENCER_SV

class i2c_sequencer extends uvm_sequencer#(.REQ(i2c_seq_item));

`uvm_component_utils(i2c_sequencer)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

endclass

`endif 
`ifndef TEST_BASE_SV
    `define TEST_BASE_SV

class test_base extends uvm_test;

    i2c_env env;

    virtual  	i2c_if 	vif;

`uvm_component_utils(test_base)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = i2c_env::type_id::create("env", this);
    
endfunction


endclass

`endif 
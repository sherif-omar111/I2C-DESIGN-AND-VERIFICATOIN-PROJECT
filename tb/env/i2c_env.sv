`ifndef I2C_ENV_SV
    `define I2C_ENV_SV

class i2c_env extends uvm_env;

i2c_agent agent ;

i2c_scoreboard	sc ; 

i2c_coverage	co ; 

`uvm_component_utils(i2c_env)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent = i2c_agent::type_id::create("agent",this);

    sc = i2c_scoreboard::type_id::create("sc",this);

    co = i2c_coverage::type_id::create("co",this);

endfunction

virtual function void connect_phase (uvm_phase phase);

super.connect_phase(phase);

`uvm_info("DEBUG", $sformatf("Hello from env connect phase"), UVM_NONE)

    agent.monitor.mon_analysis_port.connect(sc.sc_analysis_imp);

    agent.monitor.mon_analysis_port.connect(co.coverage_analysis_export);

    endfunction

endclass

`endif 
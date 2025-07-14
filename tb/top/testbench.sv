import uvm_pkg::*;

`include "uvm_macros.svh"
`include "i2c_assertions.sv"
`include "i2c_if.sv"
`include "i2c_seq_item.sv"
`include "i2c_reset_sequence.sv"
`include "i2c_write_sequence.sv"
`include "i2c_read_sequence.sv"
`include "i2c_sequencer.sv"
`include "i2c_driver.sv"
`include "i2c_monitor.sv"
`include "i2c_agent.sv"
`include "i2c_scoreboard.sv"
`include "i2c_coverage.sv"
`include "i2c_env.sv"
// ////////////////// Test Scenarios ////////////////
`include "test_base.sv"
`include "test_all.sv"

module testbench;

  reg clk;

initial begin 
    clk = 0 ;
    forever begin
    clk = #10ns ~clk ;
    end 
end 

i2c_if vif (clk);

initial begin
$dumpfile ("dump.vcd");
$dumpvars;

uvm_config_db#(virtual i2c_if)::set(null, "", "vif", vif);

// start uvm test and phases
run_test ("test_all");
end

	i2c DUT (                              
                    .clk(clk),     
                    .rst(vif.rst),      
                    .wr(vif.wr),      
                    .addr(vif.addr),   
                    .din(vif.din), 
                    .datard(vif.datard),    
                    .done(vif.done)
                    );

bind i2c i2c_assertions i2c_assert (.*);

endmodule



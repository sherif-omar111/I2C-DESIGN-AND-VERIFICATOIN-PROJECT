`ifndef TEST_ALL_SV
    `define TEST_ALL_SV

class test_all extends test_base;

`uvm_component_utils(test_all)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

i2c_reset_sequence 		    reset_seq;
i2c_write_sequence 		    write_seq;
i2c_read_sequence 		    read_seq;

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    reset_seq   = i2c_reset_sequence::type_id::create("reset_seq");
    write_seq   = i2c_write_sequence::type_id::create("write_seq");
    read_seq    = i2c_read_sequence::type_id::create("read_seq");

    endfunction

virtual task run_phase (uvm_phase phase);

    phase.raise_objection(this , "----------------------TEST STAETED----------------------");

    reset_seq.start(env.agent.sequencer);
    repeat(20) begin
            write_seq.start(env.agent.sequencer);
            read_seq.start(env.agent.sequencer);
        end
    phase.phase_done.set_drain_time(this, 50ns);

    phase.drop_objection(this, "----------------------TEST FINISHED----------------------"); 

endtask


endclass

`endif 

`ifndef I2C_SCOREBOARD_SV
    `define I2C_SCOREBOARD_SV

class i2c_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(i2c_scoreboard)

  i2c_seq_item item;
  uvm_analysis_imp #(i2c_seq_item, i2c_scoreboard) sc_analysis_imp;

  int unsigned passed_cases = 0;
  int unsigned failed_cases = 0;

  logic [7:0] ref_mem[128] = '{default:0};
  logic [7:0] ref_dout;

    function new(string name= "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
    sc_analysis_imp = new("sc_analysis_imp", this);         
    endfunction

function void write(i2c_seq_item t);
        item = t;
        if (item.rst == 1)
        begin
            `uvm_info(get_type_name(), "SYSTEM RESET DETECTED", UVM_NONE);
        end
        else begin
          if (item.wr == 1)  //write operation
            begin
                ref_mem[item.addr] = item.din;
            end

            else begin //read operation
                    ref_dout = ref_mem[item.addr];
                    if (ref_dout == item.datard)
                    begin
                        passed_cases++;
                        `uvm_info(get_type_name(), $sformatf("PASSED CASE: %0d", passed_cases), UVM_NONE)
                        `uvm_info(get_type_name(), $sformatf("ref_dout: %0d", ref_dout), UVM_NONE)
                        `uvm_info(get_type_name(), $sformatf("item.datard: %0d", item.datard), UVM_NONE)
                    end
                    else begin
                        failed_cases++;
                        `uvm_info(get_type_name(), $sformatf("FAILED CASE: %0d", failed_cases), UVM_NONE)
                      `uvm_info(get_type_name(), $sformatf("ref_dout: %0d item.datard: %0d ", ref_dout, item.datard ), UVM_NONE)
                    end
                end
        end
      
    endfunction

    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_type_name(), $sformatf("PASSED CASE: %0d", passed_cases), UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("FAILED CASE: %0d", failed_cases), UVM_NONE)
    endfunction

  endclass

`endif 

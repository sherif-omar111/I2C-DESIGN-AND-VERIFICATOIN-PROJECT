`ifndef I2C_DRIVER_SV
    `define I2C_DRIVER_SV

class i2c_driver extends uvm_driver#(.REQ(i2c_seq_item));

`uvm_component_utils(i2c_driver)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual i2c_if vif;

i2c_seq_item item;

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Could not get vif")
  endfunction
  
virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("DEBUG", $sformatf("Hello from DRIVER run phase"), UVM_NONE)
    forever begin
        seq_item_port.get_next_item(item);
        if(item.rst == 1) begin
            vif.rst <= 1;
            vif.wr <= 0;
            vif.addr <= 0;
            vif.din <= 0;
            repeat(2) begin
            @(posedge vif.clk);
            end
            vif.rst <= 0;
        end
        else begin
            vif.rst <= 0;
            vif.wr <= item.wr;
            vif.addr <= item.addr;
            vif.din <= item.din;
            @(posedge vif.done);
        end
        #1step;
        seq_item_port.item_done();
    end
    endtask


endclass

`endif
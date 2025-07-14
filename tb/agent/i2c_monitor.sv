`ifndef I2C_MONITOR_SV
  `define I2C_MONITOR_SV

  class i2c_monitor extends uvm_monitor;
  `uvm_component_utils(i2c_monitor)

    virtual i2c_if vif;

   i2c_seq_item item;

   uvm_analysis_port  #(i2c_seq_item) mon_analysis_port;

    
  function new(string name ="", uvm_component parent);
    super.new(name, parent);
    item = i2c_seq_item::type_id::create("item");
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR", "Could not get vif") 
  endfunction

virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("DEBUG", $sformatf("Monitoring in monitor"), UVM_NONE)
        forever begin
            @(posedge vif.clk);
            if(vif.rst == 1) begin 
                item.rst = 1;
                mon_analysis_port.write(item);
            end
            else begin
            @(posedge vif.done);
            item.rst = 0;
            item.wr = vif.wr;
            item.addr = vif.addr;
            item.din = vif.din;
            item.done = vif.done;
            item.datard = vif.datard;
            #1step;
            mon_analysis_port.write(item); 
            end
            
        end
        endtask

   endclass

`endif
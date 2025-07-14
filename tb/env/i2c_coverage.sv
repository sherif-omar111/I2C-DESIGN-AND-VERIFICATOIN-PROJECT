`ifndef I2C_COVERAGE_SV
    `define I2C_COVERAGE_SV

class i2c_coverage extends uvm_subscriber#(i2c_seq_item);

  `uvm_component_utils(i2c_coverage)

    uvm_analysis_imp#(i2c_seq_item,i2c_coverage) coverage_analysis_export;

    i2c_seq_item item ;

 covergroup  I2C_CVG ;

    I2C_wr        : coverpoint    item.wr ; 
    I2C_addr      : coverpoint    item.addr { bins addr_bin[] = { [0:127] }; }
    I2C_datard    : coverpoint    item.datard { bins data_bin[] = { [0:255] }; }
    
 endgroup

  function new(string name= "", uvm_component parent);
    super.new(name, parent);
    coverage_analysis_export = new("coverage_analysis_export",this);
     I2C_CVG  = new();
  endfunction

function void build_phase (uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("We are in COVERAGE build phase"), UVM_LOW)
      super.build_phase(phase);
      item = i2c_seq_item::type_id::create("item");
   endfunction

   function void write(i2c_seq_item t);

     `uvm_info("DEBUG", $sformatf("Hello from COVERAGE WRITE FUNCTION"), UVM_NONE)
        item = t;
        I2C_CVG.sample();

   endfunction 

   
    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_type_name(), $sformatf("Coverage: %0.2f%%", I2C_CVG.get_coverage()), UVM_NONE)
    endfunction

  endclass

`endif 
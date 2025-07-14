`ifndef I2C_RESET_SEQUENCE_SV
    `define I2C_RESET_SEQUENCE_SV

class i2c_reset_sequence extends uvm_sequence#(.REQ(i2c_seq_item));

//Item to drive
i2c_seq_item item;

`uvm_object_utils(i2c_reset_sequence)

function new (string name = "");
    super.new(name);
endfunction

  task pre_body();
        item = i2c_seq_item::type_id::create("item");
    endtask

    task body();
            start_item(item);
            void'(item.randomize() with {
                                  rst == 1;});
            finish_item(item);
    
    endtask

  endclass

`endif 
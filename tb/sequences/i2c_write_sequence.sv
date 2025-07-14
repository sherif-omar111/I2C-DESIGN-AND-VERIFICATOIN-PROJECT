`ifndef I2C_WRITE_SEQUENCE_SV
    `define I2C_WRITE_SEQUENCE_SV

class i2c_write_sequence extends uvm_sequence#(.REQ(i2c_seq_item));

//Item to drive
i2c_seq_item item;

int loop_var = 128;

`uvm_object_utils(i2c_write_sequence)

function new (string name = "");
    super.new(name);
endfunction

task pre_body();
        item = i2c_seq_item::type_id::create("item");
endtask


virtual task body();

      for(int i = 0; i < loop_var; i++) begin

            start_item(item);
            void'(item.randomize() with {
                                    wr == 1;
                                    rst == 0;});
            finish_item(item);
        end

  endtask

  endclass

`endif 

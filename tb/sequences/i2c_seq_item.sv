`ifndef I2C_SEQ_ITEM_SV
    `define I2C_SEQ_ITEM_SV

class i2c_seq_item extends uvm_sequence_item;
    `uvm_object_utils(i2c_seq_item)

    
    rand    logic           wr;

    rand    logic           rst;

    randc   logic [6:0]     addr;

    rand    logic [7:0]     din;

            logic [7:0]     datard;

            logic           done;

            bit             hard_reset ;   

virtual function string convert2string();

    string result =  $sformatf("wr = %0d rst= %0d addr = %0d din = %0d datard = %0d done = %0d", wr,rst,addr,din,datard,done);

    return result;

  endfunction

function new (string name = "" );
    super.new(name);
endfunction

endclass

`endif 
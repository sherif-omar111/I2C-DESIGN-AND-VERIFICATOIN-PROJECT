
`ifndef I2C_IF_SV
  `define I2C_IF_SV

interface i2c_if (input clk);

  logic           rst;
  logic           wr;
  logic   [6:0]   addr;
  logic   [7:0]   din;
  logic   [7:0]   datard;
  logic           done;
  
endinterface

`endif

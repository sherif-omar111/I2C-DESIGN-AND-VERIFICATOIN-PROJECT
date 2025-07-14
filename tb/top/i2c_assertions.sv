module i2c_assertions (
   input  wire          clk,     
   input  wire          rst,       
   input  wire          wr,       
   input  wire          [6:0] addr,         
   input  wire          [7:0] din,         
   input  wire          [7:0] datard,         
   input  wire          done
   );

property reset_check;
  @(negedge rst) 1'b1 |-> @(posedge clk) (wr == 0 && addr == 0 && din == 0);
endproperty

reset_check_assert: assert property(reset_check)
  else $error("Assertion reset_check failed!");

endmodule

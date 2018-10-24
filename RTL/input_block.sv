module input_block(

input  logic clk_ext,
       logic trigger,
       logic clk,
       logic rst,
       logic edge_mode,


output logic clk_pulse    


);

logic [7:0] clk_ext_past;

//assign clk_pulse = 1'b1;

always @(posedge clk)
if (rst)
  clk_ext_past = 8'b0;
else
  clk_ext_past = clk_ext_past << 1|clk_ext;
  
assign clk_pulse = ( (&(~clk_ext_past[3:2])) & (&clk_ext_past[1:0]) ); 

endmodule

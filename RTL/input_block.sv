module input_block(

input  logic clk_ext,
       logic trigger,
       logic clk,
       logic rst,
       logic edge_mode,


output logic clk_pulse    


);

assign clk_pulse = 1'b1;


endmodule

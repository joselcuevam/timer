// Code your testbench here
// or browse Examples

module tb_counter();
  
  
  logic [5:0]  address;
  logic [31:0] write_data;
  logic [31:0] read_data;
  logic        module_en;
  logic        write_en;
  logic 	   clk;
  logic        rst;
  
  initial
  begin
    $dumpfile("dump.vcd"); $dumpvars;
    address = 0;    
    #1000;  
    address = 10;    
  end
  
  count_registers count_registers (
    
    .clk    (clk),
    .rstn   (!rst),
    .addr   (address),
    .wr_en  (write_en),
    .mod_en (module_en),
    .rdata  (read_data),
    .wdata  (write_data)       
  
  );
  
  
endmodule

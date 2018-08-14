// Code your design here
module d_ip_timer(

  input  clk,
  input  rst_b,
  input  [5:0] addr,
  input  wr_en,
  input  mod_en,
  input  [7:0] wdata,
  output [7:0] rdata

);
  
localparam CNTR_ADDR = 6'h04;  
  
logic reg_cnt_max_value;

logic overflow_int_en;
logic out_match_1_int_en;
logic out_match_0_int_en;
logic clock_select;
logic [2:0] operation_mode;
logic start;

  
  always @(posedge clk or negedge rst_b )
  begin
      if (!rst_b)
      begin
        reg_cnt_max_value = 0;        
      end
      else
      begin
        if (addr == CNTR_ADDR & wr_en & mod_en)          
        begin
            reg_cnt_max_value = wdata;
        end          
      end      
  end  
  
  timer_registers timer_registers(
  
  .clk (clk),
  .rst (~rst_b),
  .module_en (mod_en),
  .wr (wr_en),
  .wdata (wdata),
  .addr (addr),
  .overflow_int_en(overflow_int_en),
  .out_match_1_int_en(out_match_1_int_en),
  .out_match_0_int_en(out_match_0_int_en),
  .clock_select(clock_select),
  .operation_mode(operation_mode),
  .start(start),

  .rdata (rdata)
  
  );
  
endmodule

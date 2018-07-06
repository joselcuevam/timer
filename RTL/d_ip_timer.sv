// Code your design here
module count_registers(

  input clk,
  input rstn,
  input [5:0] addr,
  input wr_en,
  input mod_en,
  input [31:0] wdata,
  input [31:0] rdata

);
  
localparam CNTR_ADDR = 6'h04;  
  
logic reg_cnt_max_value;
  
  always @(posedge clk or negedge rstn )
  begin
      if (!rstn)
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
  
  
  
endmodule

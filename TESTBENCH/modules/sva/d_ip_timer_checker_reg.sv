module d_ip_timer_checker_reg(

  input            clk,
  input            rst_b,
  input [SIZE-1:0] value

);

parameter RST_VAL = 0;
parameter SIZE = 32;


  //property to verify value after reset
  property value_after_reset_property;
    @(posedge clk) disable iff (!rst_b )
     rst_b & $past(rst_b) == 1'b0 |-> value == RST_VAL;
  endproperty
  
  assert_reset_value:assert property (value_after_reset_property);


  
endmodule

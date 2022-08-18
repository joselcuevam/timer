module d_ip_timer_checker_counter(
  input              clk,
  input              rst_b,
  input  [SIZE-1:0]  cnt_val
  
);

  parameter SIZE=0;
  
  //dummy property 
  property cnt_value_return_p;
    @(posedge clk) disable iff (!rst_b )
    cnt_val == 8'hFF |=> cnt_val == 8'h00;
  endproperty
  
  assert_dummy_cnt_p:assert property (cnt_value_return_p);


endmodule

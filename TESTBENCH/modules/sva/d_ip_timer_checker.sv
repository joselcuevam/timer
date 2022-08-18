module d_ip_timer_checker(

  input  clk,
  input  rst_b,
  
  input  [5:0] addr,
  input  wr_en,
  input  mod_en,
  input  timer_in,
  input  [7:0] wdata,
  
  input [7:0] rdata,
  input timer_out,
  input trigger,
  input overflow_int,
         comp_1_match_int,
         comp_0_match_int,
	
  input [7:0] reg_value_ctrl,
  input [7:0] reg_value_ctrl_in,
  input [7:0] reg_value_ctrl_out,
  input [7:0] reg_value_status,
  input [7:0] reg_value_cnt_init,
  input [7:0] reg_value_cnt_min,
  input [7:0] reg_value_cnt_max,
  input [7:0] reg_value_cnt,
  input [7:0] reg_value_cnt_m0,
  input [7:0] reg_value_cnt_m1                  

);

  //dummy property 
  property dummy_property;
    @(posedge clk) disable iff (!rst_b )
    ##10 rst_b |-> wr_en == 1'b1;
  endproperty
  
  assert_dummy_chk:assert property (dummy_property);


d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'hA1) ) CTRL_check          ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_ctrl) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_IN_check       ( .clk    (clk), .rst_b  (rst_b), .value  (reg_value_ctrl_in) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_OUT_check      ( .clk    (clk), .rst_b  (rst_b), .value  (reg_value_ctrl_out) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_STATUS_check   ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_status) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_CNT_INIT_check ( .clk    (clk), .rst_b  (rst_b), .value  (reg_value_cnt_init) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_CNT_MIN_check  ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_cnt_min) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'hFF) ) CTRL_CNT_MAX_check  ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_cnt_max) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_CNT_check      ( .clk    (clk), .rst_b  (rst_b), .value  (reg_value_cnt) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_CNT_M0_check   ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_cnt_m0) );
d_ip_timer_checker_reg # (  .SIZE  (8), .RST_VAL  (8'h00) ) CTRL_CNT_M1_check   ( .clk	  (clk), .rst_b  (rst_b), .value  (reg_value_cnt_m1) );



d_ip_timer_checker_counter # (  .SIZE  (8) ) cnt_check ( .clk (clk), .rst_b (rst_b), .cnt_val(reg_value_cnt) );
  
endmodule

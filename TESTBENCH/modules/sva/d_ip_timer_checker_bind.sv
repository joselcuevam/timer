bind d_ip_timer d_ip_timer_checker d_ip_timer_checker_inst (

.clk		       (clk),
.rst_b  	       (rst_b),
.addr 		       (addr),
.wr_en  	       (wr_en),
.mod_en 	       (mod_en),
.timer_in 	       (timer_in),
.wdata  	       (wdata),
.rdata  	       (rdata),
.timer_out 	       (timer_out),
.trigger 	       (trigger),
.overflow_int 	       (overflow_int),
.comp_1_match_int      (comp_1_match_int),
.comp_0_match_int      (comp_0_match_int),

.reg_value_ctrl        (timer_registers.ctrl_reg),

.reg_value_ctrl_in     (timer_registers.ctrl_in_reg),
.reg_value_ctrl_out    (timer_registers.ctrl_out_reg),
.reg_value_status      (timer_registers.status_reg),
.reg_value_cnt_init    (timer_registers.count_init),
.reg_value_cnt_min     (timer_registers.count_min),
.reg_value_cnt_max     (timer_registers.count_max),
.reg_value_cnt	       (timer_registers.counter_reg),
.reg_value_cnt_m0      (timer_registers.cnt_match_0_reg),
.reg_value_cnt_m1      (timer_registers.cnt_match_1_reg)  


);

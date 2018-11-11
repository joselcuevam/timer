`SHOWM(Free run counter with trigger);

reg_read(`TIMER_CTRL_ADDR);
reg_write(`TIMER_CNT_MATCH_0_ADDR,8'h50);
reg_write(`TIMER_CNT_MATCH_1_ADDR,8'h7A);
reg_write(`TIMER_CTRL_OUT_ADDR,8'h70);
reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_read(`TIMER_CTRL_ADDR);
delay(1000);

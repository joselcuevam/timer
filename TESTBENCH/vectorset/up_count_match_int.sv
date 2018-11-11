`SHOWM(UP counter match interruption mode);

reg_read(`TIMER_CTRL_ADDR);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CNT_MAX_ADDR,8'h64);
reg_write(`TIMER_CNT_MIN_ADDR,8'h00);
reg_write(`TIMER_CNT_MATCH_0_ADDR,8'h32);
reg_write(`TIMER_CTRL_ADDR,8'h21);
delay(54);
reg_write(`TIMER_CTRL_ADDR,8'h01);
delay(1000);

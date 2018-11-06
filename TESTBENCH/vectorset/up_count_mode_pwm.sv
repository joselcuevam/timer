`SHOWM(UP counter mode);

reg_read(`TIMER_CTRL_ADDR);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CNT_MAX_ADDR,8'h64);
reg_write(`TIMER_CNT_MIN_ADDR,8'h00);
reg_write(`TIMER_CNT_MATCH_0_ADDR,8'h32);
reg_write(`TIMER_CNT_MATCH_1_ADDR,8'h64);
reg_write(`TIMER_CTRL_OUT_ADDR,8'h01);
reg_write(`TIMER_CTRL_ADDR,8'h01);
delay(1000);

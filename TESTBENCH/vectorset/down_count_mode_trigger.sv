`SHOWM(Down counter mode trigger);

reg_read(`TIMER_CTRL_ADDR);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CNT_MAX_ADDR,8'hAA);
reg_write(`TIMER_CNT_INIT_ADDR,8'hAA);
reg_write(`TIMER_CNT_MIN_ADDR,8'h2A);
reg_write(`TIMER_CNT_MATCH_0_ADDR,8'h3A);
reg_write(`TIMER_CNT_MATCH_1_ADDR,8'h4A);
reg_write(`TIMER_CTRL_OUT_ADDR,8'h70);
reg_write(`TIMER_CTRL_ADDR,8'h02);
reg_write(`TIMER_CTRL_ADDR,8'h03);
delay(1000);

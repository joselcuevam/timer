`SHOWM(Input external clock prescaler);

reg_read(`TIMER_CTRL_ADDR);
reg_write(`TIMER_CTRL_IN_ADDR,8'h30);
reg_write(`TIMER_CNT_MAX_ADDR,8'd10);
reg_write(`TIMER_CTRL_ADDR,8'h09);
delay(1000);

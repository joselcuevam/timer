`SHOWM(Free count counter mode);

reg_read(`TIMER_CTRL_ADDR);
reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_read(`TIMER_CTRL_ADDR);
delay(1000);

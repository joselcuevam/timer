`SHOWM(UP counter mode);

reg_read(`TIMER_CTRL_ADDR);
reg_write(`TIMER_CTRL_ADDR,8'h11);

delay(1000);

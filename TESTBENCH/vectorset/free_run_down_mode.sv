`SHOWM(Free count down counter mode);

reg_read(`TIMER_CTRL_ADDR);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CTRL_ADDR,8'h02);
reg_write(`TIMER_CTRL_ADDR,8'h03);
reg_read(`TIMER_CTRL_ADDR);
delay(1000);

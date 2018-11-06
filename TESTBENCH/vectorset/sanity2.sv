`SHOWM(starting testcase);

#200;
`SHOWM(define initial values for conrol signals);
`TB_SCOPE.rst = 1;
`TB_SCOPE.module_en =0;
`TB_SCOPE.write_en =0;
`TB_SCOPE.write_data =0;
`TB_SCOPE.address =100;

`SHOWM(reset timer);
#200 `TB_SCOPE.rst = 0;

`SHOWM(Write to control register);
//reg_write(`TIMER_CTRL_ADDR,8'h01); //free up
reg_read(`TIMER_CTRL_ADDR);
`SHOWM(Write to count register);
reg_write(`TIMER_CNT_ADDR,8'hAA);
reg_read(`TIMER_CNT_ADDR);
`SHOWM(Write to count match 1 register);
reg_write(`TIMER_CNT_MATCH_1_ADDR,8'hBA);
reg_read(`TIMER_CNT_MATCH_1_ADDR);
`SHOWM(Write to count match 2 register);
reg_write(`TIMER_CNT_MATCH_2_ADDR,8'h10);
reg_read(`TIMER_CNT_MATCH_2_ADDR);
`SHOWM(Write to control in register);
reg_write(`TIMER_CTRL_IN_ADDR,8'h01);
reg_read(`TIMER_CTRL_IN_ADDR);
`SHOWM(Write to control out register);
//reg_write(`TIMER_CTRL_OUT_ADDR,8'h01);
reg_write(`TIMER_CTRL_OUT_ADDR,8'h03);
reg_read(`TIMER_CTRL_OUT_ADDR);
`SHOWM(Write to control register);
//reg_write(`TIMER_CTRL_ADDR,8'h01);
reg_write(`TIMER_CTRL_ADDR,8'h09);

reg_read(`TIMER_CTRL_ADDR);
#30000;

#200 `TB_SCOPE.rst = 1;
#5000;
#200 `TB_SCOPE.rst = 0;


reg_write(`TIMER_CNT_INIT_REG_ADDR,8'h0B);
reg_write(`TIMER_CNT_MIN_ADDR,8'h2A);
reg_write(`TIMER_CNT_MAX_ADDR,8'h90);

#300
reg_read(`TIMER_CNT_INIT_REG_ADDR);
reg_read(`TIMER_CNT_MIN_ADDR);
reg_read(`TIMER_CNT_MAX_ADDR);
reg_write(`TIMER_CNT_MATCH_1_ADDR,8'h30);
reg_write(`TIMER_CNT_MATCH_2_ADDR,8'h70);
reg_write(`TIMER_CTRL_ADDR,8'h3); // up no free

#6500

reg_write(`TIMER_STATUS_ADDR,8'hFF);

#5000;
// down count
reg_write(`TIMER_CTRL_ADDR,8'h05); // down free

#5000;
// up count
reg_write(`TIMER_STATUS_ADDR,8'hFF);
reg_write(`TIMER_CTRL_ADDR,8'h01);
#2000;
reg_write(`TIMER_CTRL_ADDR,8'h7); // down no free

#6000 `TB_SCOPE.rst = 1;

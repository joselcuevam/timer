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
reg_write(`TIMER_CTRL_ADDR,8'hFF);
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

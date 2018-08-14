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

`TB_SCOPE.address = 0;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.write_data = 8'hA;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.module_en = 1'b1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.write_en  = 1'b1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.module_en = 1'b0;
`TB_SCOPE.write_data = 8'hF;
@(posedge `TB_SCOPE.clk);

`SHOWM(Write to control register done);


`SHOWM(Write to count register);

`TB_SCOPE.address = 1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.write_data = 8'hA;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.module_en = 1'b1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.write_en  = 1'b1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.module_en = 1'b0;
`TB_SCOPE.write_data = 8'hF;
@(posedge `TB_SCOPE.clk);

`SHOWM(Write to count register done);

#100;  
`TB_SCOPE.address = 10;
#400;  
`TB_SCOPE.address = 15;

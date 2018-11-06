task startup_task();
begin
  #200;
  `SHOWM(define initial values for control signals);
  `TB_SCOPE.rst = 1;
  `TB_SCOPE.module_en =0;
  `TB_SCOPE.write_en =0;
  `TB_SCOPE.write_data =0;
  `TB_SCOPE.address =100;
  `SHOWM(reset timer);
  #200 `TB_SCOPE.rst = 0;
  `SHOWM(starting testcase);
end
endtask

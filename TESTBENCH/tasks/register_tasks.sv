logic [7:0] reg_read_data;

assign reg_read_data = `TB_SCOPE.read_data;


task reg_write(reg [7:0] address,reg [7:0] data);
begin
  $display("[%m] : Write A=h%02h W=h%02h T=%0d",address,data,$stime);
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.address    = address;
`TB_SCOPE.write_data = data;
`TB_SCOPE.module_en  = 1'b1;
`TB_SCOPE.write_en   = 1'b1;
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.address    = 8'b0;
`TB_SCOPE.write_data = 8'b0;
`TB_SCOPE.module_en  = 1'b0;
`TB_SCOPE.write_en   = 1'b0;
end
endtask

task reg_read(reg [7:0] address);
begin
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.address    = address;
`TB_SCOPE.module_en  = 1'b1;
`TB_SCOPE.write_en   = 1'b0;
 #1
  $display("[%m ] : Read  A=h%02h R=h%02h T=%0d",address,reg_read_data,$stime);
@(posedge `TB_SCOPE.clk);
`TB_SCOPE.address    = 8'b0;
`TB_SCOPE.module_en  = 1'b0;
`TB_SCOPE.write_en   = 1'b0;
end
endtask

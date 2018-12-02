module clock_gen(
  output  out
  );


  reg      clk;
  reg      enabled;
  real     period;
  integer  cycle;
  reg      clock_alt;
  
  
  parameter real    PERIOD   = 1;
  parameter integer CYCLE    = 50;
  parameter      EN       = 1;
  parameter      INIT_VAL = 0;

  initial
  begin
    clk     = INIT_VAL;
    enabled = EN;
    period  = PERIOD;
    cycle   = CYCLE;
    clock_alt =0;
  end

  task on;
  begin
    enabled = 1;
  end
  endtask

  task off;
  begin
    enabled = 0;
  end
  endtask

  task set_period;
    input value;
    real value;
  begin
    period = value;
  end
  endtask

  task set_duty_cycle;
    input value;
    real value;
  begin
    cycle = value;
  end
  endtask

  always
  begin
    while(enabled == 1)
    begin
      #(period-(period*cycle/100)) clk = (clk === 1'bx)?0:~clk;
      #(period*cycle/100)  clk = (clk === 1'bx)?0:~clk;
    end
  end
  
  // This clock remains active in CPF simulation
  always
  begin
    while(clock_alt == 1|clock_alt == 0)
    begin
      #(period-(period*cycle/100)) clock_alt = (clock_alt === 1'bx)?0:~clock_alt;
      #(period*cycle/100)  clock_alt = (clock_alt === 1'bx)?0:~clock_alt;
    end
  end 
  
  assign out = clock_alt;

endmodule

module clock_div(
  input           in,
  output reg [11:0]  out
  );

  initial
  begin
    out = 16'd0;
  end

  always @(posedge in)
  begin
    out = out + 1'b1;
  end

endmodule

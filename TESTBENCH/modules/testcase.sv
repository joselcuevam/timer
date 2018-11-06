module testcase();

initial
begin
`SHOWM(===========================);
`SHOWM(Starting simulation);
`SHOWM(===========================);

startup_task();

//`include "../TESTBENCH/vectorset/free_run.sv"
//`include "../TESTBENCH/vectorset/free_run_down_mode.sv"
//`include "../TESTBENCH/vectorset/up_count_mode.sv"
//`include "../TESTBENCH/vectorset/down_count_mode.sv"
//`include "../TESTBENCH/vectorset/input_pulses_counter.sv"
//`include "../TESTBENCH/vectorset/sanity2.sv"
//`include "../TESTBENCH/vectorset/up_count_mode_pwm.sv"
//`include "../TESTBENCH/vectorset/up_count_match_int.sv"
//`include "../TESTBENCH/vectorset/up_count_overflow_int.sv"

`include "../TESTBENCH/vectorset/input_ext_clk_prescaler.sv"


`SHOWM(===========================);
`SHOWM(End simulation);
`SHOWM(===========================);
    

end

endmodule

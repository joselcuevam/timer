// Code your testbench here
// or browse Examples

module tb_counter();
  
  
  reg [5:0]  address;
  reg [7:0]  write_data;
  wire [7:0]  read_data;
  reg        module_en;
  reg        write_en;
  reg        rst;
  
  wire        overflow_int;
  wire        match0_int;  
  wire        match1_int;
  wire        timer_out;
  wire        clk_ext;
  wire        trigger;
  
  // Simulator control  
  initial
  begin
    $dumpfile("dump.vcd"); $dumpvars;
    $display("Starting simulation...");
    #90000;
    $finish;    
  end
  
  //tasks
  `include "register_tasks.sv"
  `include "common_tasks.sv"
  
  wire [7:0] reg_read_data;

  assign reg_read_data = `TB_SCOPE.read_data;

  // clock 
  
  wire        clk;
  wire [11:0] clk_div;

  testcase testcase ();
  
  clock_gen #( .PERIOD (20)  )
  clock_gen (  .out (clk)    );
      
  clock_div  clock_div (clk,clk_div);
  
  clock_gen #( .PERIOD (200) )
  clock_gen_ext ( .out (clk_ext) );

  // pulses
  reg [15:0] random_val;
  reg        pulses;
  
  initial
  begin
    pulses =0; 
    while (1)
    begin
      random_val=$urandom%100;
      repeat(random_val + 20) begin @ (posedge clk);  end
      pulses = ~pulses;
    end  
  end

  
  d_ip_timer d_ip_timer (
    
    .clk    (clk),
    .rst_b  (!rst),
    .addr   (address),
    .wr_en  (write_en),
    .mod_en (module_en),
    .rdata  (read_data),
    .wdata  (write_data),
    .overflow_int (overflow_int),
    .comp_0_match_int (match0_int),
    .comp_1_match_int (match1_int),
    .timer_out (timer_out),
    //.timer_in (pulses)  
    .timer_in (clk_ext) 
  );
  
  
endmodule

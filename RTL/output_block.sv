module output_block
#(
    parameter NUM_COMP  = 3
)
(
input        rst,
input        clk,
input        en,
input       [NUM_COMP-1:0] [7:0] match_value,
input       [7:0] counter_value,
input       [NUM_COMP-1:0] intr_en,
input       [NUM_COMP-1:0] trg_en,
input       [NUM_COMP-1:0] flag,        
input        pwm_mode,
        inv,

output  timer_out,
        trigger,
output        [NUM_COMP-1:0] intr,      
output        [NUM_COMP-1:0] match
       
);

  reg timer_out_internal;
  
  wire high_pwm;
  wire low_pwm;
  reg [NUM_COMP-1:0] match_past;
  wire [NUM_COMP-1:0] match_rise;
  wire [NUM_COMP-1:0] trigger_internal;
  
  assign trigger = |trigger_internal;
  
  genvar a;
  
  for (a = 0;a < NUM_COMP; a=a+1 )
  begin
    assign match[a] = (match_value[a] == counter_value);
    assign match_rise[a] = (~match_past[a] & match[a]);
  end

  for (a = 0;a < NUM_COMP; a=a+1 )
  begin
    assign trigger_internal[a] = (match[a] & trg_en[a]);
  end 

  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      match_past =0;
    else
      match_past = match;  
  end  
  //PWM
  
  //set if comp match 0
  //unset if comp match 1
  assign high_pwm = match_rise[0] & en & pwm_mode;  
  assign low_pwm  = match_rise[1] & en & pwm_mode;

  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      timer_out_internal =0;
    else
        if (high_pwm)
          timer_out_internal =1;
        else if (low_pwm)
          timer_out_internal =0;
        else 
          timer_out_internal = timer_out_internal;    
  end
  
  assign intr = (intr_en & flag );
  assign timer_out = inv?~timer_out_internal:timer_out_internal;
  
endmodule

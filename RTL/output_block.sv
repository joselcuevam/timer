module output_block
#(
    parameter NUM_COMP  = 3
)
(
input  logic rst,
       logic clk,
       logic en,
       logic [NUM_COMP-1:0] [7:0] match_value,
       logic [7:0] counter_value,
       logic [NUM_COMP-1:0] intr_en,
       logic [NUM_COMP-1:0] flag,        
       logic pwm_mode,
       logic inv,


output logic timer_out,
       logic [NUM_COMP-1:0] intr,      
       logic [NUM_COMP-1:0] match
       
);

  logic timer_out_internal;
  
  logic high_pwm;
  logic low_pwm;
  logic [NUM_COMP-1:0] match_past;
  logic [NUM_COMP-1:0] match_rise;
  
  genvar a;
  
  for (a = 0;a < NUM_COMP; a=a+1 )
  begin
    assign match[a] = (match_value[a] == counter_value);
    assign match_rise[a] = (~match_past[a] & match[a]);
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

module output_block
#(
    parameter NUM_COMP  = 3
)
(
input  logic rst,
       logic clk,
       logic [NUM_COMP-1:0] [7:0] match_value,
       logic [7:0] counter_value,
       logic [NUM_COMP-1:0] intr_en,
        
       logic pwm_mode,


output logic timer_out,
       logic [NUM_COMP-1:0] intr,      
       logic [NUM_COMP-1:0] flag
);

  genvar a;
  
  for (a = 0;a < NUM_COMP; a=a+1 )
  begin
    assign flag[a] = (match_value[a] == counter_value);  
  end
  
  //PWM
  
  //set if comp match 0
  //unset if comp match 1

  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      timer_out =0;
    else
        if (flag[0])
          timer_out =1;
        else if (flag[1])
          timer_out =0;
        else 
          timer_out = timer_out;    
  end
  
  assign intr = (intr_en & flag );
    
endmodule

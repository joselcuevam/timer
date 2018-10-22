module timer_counter
      #(
          parameter COUNTER_SIZE  = 8    // counter size
        )(
           input   logic                     clk,
                                             clk_pulse,
                                             rst,
                                             up,
                                             down,
                                             free,
                                             init_cnt,
           input   logic [COUNTER_SIZE-1:0]  min,
           input   logic [COUNTER_SIZE-1:0]  max,
           input   logic [COUNTER_SIZE-1:0]  init,                      
           output  logic [COUNTER_SIZE-1:0]  value,
                   logic                     overflow
       );

always @(posedge clk or posedge rst)
begin
  if (rst)
      value = 0;
  else if (init_cnt)
      value = init;
  else
  begin
    if (clk_pulse)
    begin
       if ( (up|free) & ~down )
       begin
          if (~free)
          begin
            if (value < max)
              value = value + 1;
            else if (value >= max)
              value = min;
          end
          else
          begin
             value = value + 1;
          end
       end
       else if ( (down|free) & ~up )
       begin
          if (~free)
          begin
            if (value > min)
              value = value - 1;
            else if (value <= min)
              value = max;
          end
          else
          begin
             value = value - 1;
          end
       end
       else
         value = value;
    end
  end      
end

assign overflow = (value == {COUNTER_SIZE{1'b1}});

endmodule

module timer_counter
      #(

          parameter COUNTER_SIZE  = 8    // counter size

        )(
           input   logic                     clk,
                                             rst,
                                             up,
                                             down,

           output  logic [COUNTER_SIZE-1:0]  value,
                   logic                     overflow

       );


always @(posedge clk or posedge rst)
begin
  if (rst)
      value = 0;
  else
      if (up & ~down)
        value = value + 1;
      else if (down & ~up)
        value = value - 1;
      else
        value = value;
                
end

always @(posedge clk or posedge rst)
begin
  if (rst)
      overflow = 0;
  else
      if (value == {COUNTER_SIZE{1'b1}})
        overflow = 1;
      else
        overflow = 0;
end



endmodule

// Code your design here
module d_ip_timer(
  input  clk,
  input  rst_b,
  input  [5:0] addr,
  input  wr_en,
  input  mod_en,
  input  clk_ext,
  input  trigger,
  input  [7:0] wdata,
  output [7:0] rdata,
  output timer_out,
  output overflow_int,
         comp_1_match_int,
         comp_0_match_int
         
);

localparam CNTR_ADDR=6'h04;  
localparam COUNTER_SIZE=8;
localparam NUM_COMP=2;

logic                     overflow_int_en;
logic                     out_match_1_int_en;
logic                     out_match_0_int_en;
logic                     clock_select;
logic                     count_mode;
logic                     start;
logic [COUNTER_SIZE-1:0]  counter_value;
logic                     counter_overflow;

logic [COUNTER_SIZE-1:0]  match_1_value;
logic [COUNTER_SIZE-1:0]  match_0_value;

logic [COUNTER_SIZE-1:0]  count_min;
logic [COUNTER_SIZE-1:0]  count_max;
logic [COUNTER_SIZE-1:0]  count_init;

logic overflow_status_flag;
logic cnt_match_0_status_flag;
logic cnt_match_1_status_flag;
logic cnt_match_0_status_flag_set;
logic cnt_match_1_status_flag_set;


logic start_1;
logic start_rise;
  

logic up_count;
logic down_count;
logic free_mode;
logic clk_pulse;
logic pwm_mode;
logic edge_mode;

  //decode
  assign  up_count   = ~count_mode;
  assign  down_count =  count_mode;  
  assign  ext_clock_select = clock_select;
  
  //edge detector
  always @ (posedge clk) begin
    start_1 <= start;
  end  
  assign start_rise = start & ~start_1;

  
  timer_registers timer_registers(
  .clk (clk),
  .rst (~rst_b),
  .module_en (mod_en),
  .wr (wr_en),
  .wdata (wdata),
  .addr (addr),
  .overflow_int_en(overflow_int_en),
  .out_match_1_int_en(out_match_1_int_en),
  .out_match_0_int_en(out_match_0_int_en),
  .clock_select(clock_select),
  .count_mode(count_mode),
  .force_free (free_mode),
  .count_init(count_init),
  .count_min(count_min),
  .count_max(count_max),
  .match_1_value(match_1_value),
  .match_0_value(match_0_value),
  .overflow_status_flag(overflow_status_flag),
  .cnt_match_0_status_flag(cnt_match_0_status_flag),
  .cnt_match_1_status_flag(cnt_match_1_status_flag),
  .overflow(counter_overflow),
  .match_0(cnt_match_0_status_flag_set),
  .match_1(cnt_match_1_status_flag_set),     
  .start(start),
  .pwm_mode(pwm_mode),
  .edge_mode(edge_mode),
  .rdata (rdata)
  );
  
  timer_counter #(
    .COUNTER_SIZE (COUNTER_SIZE)               
  )                                            
  timer_counter(                               
    .clk(clk),
    .clk_pulse(clk_pulse & ext_clock_select| ~ext_clock_select),
    .rst(~rst_b),
    .up (up_count ),
    .down ( down_count ),                             
    .value(counter_value),
    .min (count_min),
    .max (count_max),
    .init (count_init),
    .free (free_mode),
    .init_cnt(start_rise),
    .overflow(counter_overflow)                     
  );
  
  assign overflow_int = overflow_int_en && overflow_status_flag;
  
  input_block  input_block (
  
  .clk       (clk),
  .clk_ext   (clk_ext),
  .trigger   (trigger),
  .rst       (~rst_b),
  .edge_mode (edge_mode),  
  .clk_pulse (clk_pulse)
      
  );

  output_block  #(
    .NUM_COMP (NUM_COMP)               
  )    output_block (
  
  .clk           (clk),
  .rst           (~rst_b),
  .counter_value (counter_value),
  .pwm_mode      (pwm_mode),
  .timer_out     (timer_out),
  .match_value   ({ match_0_value,
                    match_1_value  }),
  .flag          ({ cnt_match_0_status_flag_set,
                    cnt_match_1_status_flag_set}),
  .intr_en       ({ out_match_0_int_en,
                    out_match_1_int_en }),
  .intr          ({ comp_0_match_int,
                    comp_1_match_int   })

  );

   

endmodule

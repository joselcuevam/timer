// Code your design here
module d_ip_timer(
  input  clk,
  input  rst_b,
  input  [5:0] addr,
  input  wr_en,
  input  mod_en,
  input  timer_in,
  input  [7:0] wdata,
  output [7:0] rdata,
  output timer_out,
  output trigger,
  output overflow_int,
         comp_1_match_int,
         comp_0_match_int
         
);

localparam CNTR_ADDR=6'h04;  
localparam COUNTER_SIZE=8;
localparam NUM_COMP=2;

wire                     overflow_trg_en;
wire                     out_match_1_trg_en;
wire                     out_match_0_trg_en;
wire                     overflow_int_en;
wire                     out_match_1_int_en;
wire                     out_match_0_int_en;
wire                     clock_select;
wire                     count_mode;
wire                     start;
wire [COUNTER_SIZE-1:0]  counter_value;
wire                     counter_overflow;

wire [COUNTER_SIZE-1:0]  match_1_value;
wire [COUNTER_SIZE-1:0]  match_0_value;

wire [COUNTER_SIZE-1:0]  count_min;
wire [COUNTER_SIZE-1:0]  count_max;
wire [COUNTER_SIZE-1:0]  count_init;

wire overflow_status_flag;
wire cnt_match_0_status_flag;
wire cnt_match_1_status_flag;
wire cnt_match_0_status_flag_set;
wire cnt_match_1_status_flag_set;


reg start_1;
wire start_rise;
  

wire up_count;
wire down_count;
wire free_mode;
wire clk_pulse;
wire pwm_mode;
wire edge_mode;
wire inv;
wire trigger_int;
wire enable_operation;
wire [2:0] prescaler;

  //decode
  assign  ext_clock_select = clock_select;
  
  //edge detector
  always @ (posedge clk) begin
    start_1 <= start;
  end  
  assign start_rise = start & ~start_1;


  assign enable_operation = clk_pulse & ext_clock_select & start| ~ext_clock_select & start;
  
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
  .overflow_trg_en(overflow_trg_en),
  .out_match_1_trg_en(out_match_1_trg_en),
  .out_match_0_trg_en(out_match_0_trg_en),
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
  .inv(inv),
  .prescaler(prescaler),
  .pwm_mode(pwm_mode),
  .edge_mode(edge_mode),
  .cnt_init_wr(cnt_init_wr),
  .rdata (rdata)
  );
  
  timer_counter #(
    .COUNTER_SIZE (COUNTER_SIZE)               
  )                                            
  timer_counter(                               
    .clk(clk),
    .en(enable_operation),
    .rst(~rst_b),
    .cnt_mode ( ~count_mode ),                             
    .value(counter_value),
    .min (count_min),
    .max (count_max),
    .init (count_init),
    .free (free_mode),
    .init_cnt(cnt_init_wr),
    .overflow_set(counter_overflow)                     
  );
  
  assign overflow_int = overflow_int_en && overflow_status_flag;
  
  input_block  input_block (
  
  .clk       (clk),
  .clk_ext   (timer_in),
  .rst       (~rst_b),
  .edge_mode (edge_mode),  
  .clk_pulse (clk_pulse),
  .ps        (prescaler)
      
  );

  output_block  #(
    .NUM_COMP (NUM_COMP)               
  )    output_block (
  
  .clk           (clk),
  .rst           (~rst_b),
  .counter_value (counter_value),
  .pwm_mode      (pwm_mode),
  .timer_out     (timer_out),
  .match_value   ({ match_1_value,
                    match_0_value  }),
  .match         ({ cnt_match_1_status_flag_set,
                    cnt_match_0_status_flag_set}),
  .flag          ({ cnt_match_1_status_flag,
                    cnt_match_0_status_flag}),
  .intr_en       ({ out_match_1_int_en,
                    out_match_0_int_en }),
  .trg_en        ({ out_match_1_trg_en,
                    out_match_0_trg_en   }),
  .intr          ({ comp_1_match_int,
                    comp_0_match_int   }),
  .inv           (inv),
  .en            (enable_operation),
  .trigger       (trigger_int)
  );

  assign trigger = trigger_int | (counter_overflow & overflow_trg_en);

endmodule

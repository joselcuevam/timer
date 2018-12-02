module timer_registers(
           input   logic      clk,
           rst,
           module_en,
           wr,
           
           input [7:0]  wdata,
           input [5:0]  addr,
           output   [7:0]  rdata,
           output reg overflow_int_en,
           output reg out_match_0_int_en,
           output reg out_match_1_int_en,
           output reg clock_select,
           output reg force_free,
           output reg count_mode,
           output reg [7:0] match_1_value,
           output reg [7:0] match_0_value,
           output reg       start,
           output reg [2:0] prescaler,

           output reg overflow_trg_en,
           output reg out_match_1_trg_en,
           output reg out_match_0_trg_en,                   
           
           input   overflow,
           input   match_0,
           input   match_1,
           
           output reg overflow_status_flag,
           output reg cnt_match_0_status_flag,
           output reg cnt_match_1_status_flag,
           
           output reg [7:0] count_init,
           output reg [7:0] count_min,
           output reg [7:0] count_max,
           
           output reg       edge_mode,
           output reg       pwm_mode,
           output reg       cnt_init_wr,
           output reg       inv         
         
       );
       
localparam CTRL_REG_RST         = 8'h0;
localparam CTRL_IN_REG_RST      = 8'h0;
localparam CTRL_OUT_REG_RST     = 8'h0;
localparam STATUS_REG_RST       = 8'h0;
localparam CNT_INIT_REG_RST     = 8'h0;
localparam CNT_MIN_REG_RST      = 8'h0;
localparam CNT_MAX_REG_RST      = 8'hFF;
localparam CNT_REG_RST          = 8'h0;
localparam CNT_REG_MATCH_0_RST  = 8'h0;
localparam CNT_REG_MATCH_1_RST  = 8'h0;

localparam CTRL_REG_ADDR        = 8'h0;
localparam CTRL_IN_REG_ADDR     = 8'h1;
localparam CTRL_OUT_REG_ADDR    = 8'h2;
localparam STATUS_REG_ADDR      = 8'h4;
localparam CNT_INIT_REG_ADDR    = 8'h8;
localparam CNT_MIN_REG_ADDR     = 8'h9;
localparam CNT_MAX_REG_ADDR     = 8'hA;
localparam CNT_REG_ADDR         = 8'hB;
localparam CNT_REG_MATCH_0_ADDR = 8'hC;
localparam CNT_REG_MATCH_1_ADDR = 8'hD;

wire ctrl_reg_sel     = (addr == CTRL_REG_ADDR);
wire ctrl_in_reg_sel  = (addr == CTRL_IN_REG_ADDR);
wire ctrl_out_reg_sel = (addr == CTRL_OUT_REG_ADDR);
wire status_reg_sel   = (addr == STATUS_REG_ADDR);
wire cnt_init_reg_sel = (addr == CNT_INIT_REG_ADDR);
wire cnt_min_reg_sel  = (addr == CNT_MIN_REG_ADDR);
wire cnt_max_reg_sel  = (addr == CNT_MAX_REG_ADDR);
wire cnt_reg_sel      = (addr == CNT_REG_ADDR);
wire cnt_match_1_sel  = (addr == CNT_REG_MATCH_1_ADDR);
wire cnt_match_0_sel  = (addr == CNT_REG_MATCH_0_ADDR);

wire         wr_en;
wire         rd_en;
reg  [7:0]  rdata_mux_out;

assign wr_en = module_en &  wr;
assign rd_en = module_en & ~wr;

//register ctrl
wire  [7:0] ctrl_reg;
assign ctrl_reg = {
           force_free,
           overflow_int_en,
           out_match_1_int_en,
           out_match_0_int_en,
           clock_select,
           1'b0,
           count_mode,
           start
       };
always @(posedge clk or posedge rst)
begin
    if (rst)
        start = CTRL_REG_RST[0];
    else
        if (wr_en & ctrl_reg_sel)
            start = wdata[0];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        count_mode = CTRL_REG_RST[1];
    else
        if (wr_en & ctrl_reg_sel)
            count_mode = wdata[1];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        clock_select = CTRL_REG_RST[3];
    else
        if (wr_en & ctrl_reg_sel)
            clock_select = wdata[3];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        overflow_int_en = CTRL_REG_RST[4];
    else
        if (wr_en & ctrl_reg_sel)
            overflow_int_en = wdata[4];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_0_int_en = CTRL_REG_RST[5];
    else
        if (wr_en & ctrl_reg_sel)
            out_match_0_int_en = wdata[5];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_1_int_en = CTRL_REG_RST[6];
    else
        if (wr_en & ctrl_reg_sel)
            out_match_1_int_en = wdata[6];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        force_free = CTRL_REG_RST[7];
    else
        if (wr_en & ctrl_reg_sel)
            force_free = wdata[7];
end




//register ctrl_in

wire [7:0] ctrl_in_reg;


assign ctrl_in_reg = {
           1'b0,
           prescaler,
           3'b0,
           edge_mode
       };

always @(posedge clk or posedge rst)
begin
    if (rst)
        edge_mode = CTRL_IN_REG_RST[0];
    else
        if (wr_en & ctrl_in_reg_sel)
            edge_mode = wdata[0];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        prescaler = CTRL_IN_REG_RST[6:4];
    else
        if (wr_en & ctrl_in_reg_sel)
            prescaler = wdata[6:4];
end


//register ctrl_out

wire [7:0] ctrl_out_reg;


assign ctrl_out_reg = {
           1'b0,
           out_match_1_trg_en,
           out_match_0_trg_en,
           overflow_trg_en,
           2'b0,
           inv,
           pwm_mode
       };

always @(posedge clk or posedge rst)
begin
    if (rst)
        pwm_mode = CTRL_OUT_REG_RST[0];
    else
        if (wr_en & ctrl_out_reg_sel)
            pwm_mode = wdata[0];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        inv = CTRL_OUT_REG_RST[1];
    else
        if (wr_en & ctrl_out_reg_sel)
            inv = wdata[1];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        overflow_trg_en = CTRL_OUT_REG_RST[4];
    else
        if (wr_en & ctrl_out_reg_sel)
            overflow_trg_en = wdata[4];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_0_trg_en = CTRL_OUT_REG_RST[5];
    else
        if (wr_en & ctrl_out_reg_sel)
            out_match_0_trg_en = wdata[5];
end
always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_1_trg_en = CTRL_OUT_REG_RST[6];
    else
        if (wr_en & ctrl_out_reg_sel)
            out_match_1_trg_en = wdata[6];
end

//register status
 
wire  [7:0] status_reg;

always @(posedge clk or posedge rst)
begin
    if (rst)
        overflow_status_flag = 0;
    else
        if (overflow)
            overflow_status_flag = 1;
        else if (wr_en & status_reg_sel & wdata[0])
            overflow_status_flag = 0;
           
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        cnt_match_0_status_flag = 0;
    else
        if (match_0 & start)
            cnt_match_0_status_flag = 1;
        else if (wr_en & status_reg_sel & wdata[1])
            cnt_match_0_status_flag = 0;
    
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        cnt_match_1_status_flag = 0;
    else
        if (match_1 & start)
            cnt_match_1_status_flag = 1;
        else if (wr_en & status_reg_sel & wdata[2])
            cnt_match_1_status_flag = 0;
            
end

assign status_reg = {5'b0,cnt_match_1_status_flag,cnt_match_0_status_flag,overflow_status_flag};

//register count_init

always @(posedge clk or posedge rst)
begin
    if (rst)
        count_init = CNT_INIT_REG_RST;
    else
        if (wr_en & cnt_init_reg_sel)
           count_init = wdata;
end


always @(posedge clk or posedge rst)
begin
    if (rst)
       cnt_init_wr =0;
    else if  (wr_en & cnt_init_reg_sel)
      cnt_init_wr = 1;
    else
      cnt_init_wr = 0;
end


//register count_min

always @(posedge clk or posedge rst)
begin
    if (rst)
        count_min = CNT_MIN_REG_RST;
    else
        if (wr_en & cnt_min_reg_sel)
            count_min = wdata;
end

//register count_max

always @(posedge clk or posedge rst)
begin
    if (rst)
        count_max = CNT_MAX_REG_RST;
    else
        if (wr_en & cnt_max_reg_sel)
            count_max = wdata;
end


//register count

logic [7:0] counter;
wire [7:0] counter_reg;
always @(posedge clk or posedge rst)
begin
    if (rst)
        counter = CNT_REG_RST;
    else
        if (wr_en & cnt_reg_sel)
            counter = wdata;
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        counter = CNT_REG_RST;
    else
        if (wr_en & cnt_reg_sel)
            counter = wdata;
end


assign counter_reg = counter;


//register output match_0 value
wire [7:0] cnt_match_0_reg;
always @(posedge clk or posedge rst)
begin
    if (rst)
        match_0_value = CNT_REG_MATCH_0_RST;
    else
        if (wr_en & cnt_match_0_sel)
            match_0_value = wdata;
end
assign cnt_match_0_reg = match_0_value;
//register output match_1 value
wire [7:0] cnt_match_1_reg;
always @(posedge clk or posedge rst)
begin
    if (rst)
        match_1_value = CNT_REG_MATCH_1_RST;
    else
        if (wr_en & cnt_match_1_sel)
            match_1_value = wdata;
end
assign cnt_match_1_reg = match_1_value;

//read register
always @ (*)
begin : MUX
    case(addr )
        CTRL_REG_ADDR : rdata_mux_out = ctrl_reg;
        CTRL_IN_REG_ADDR : rdata_mux_out = ctrl_in_reg;
        CTRL_OUT_REG_ADDR : rdata_mux_out = ctrl_out_reg;
        STATUS_REG_ADDR : rdata_mux_out = status_reg;
        CNT_REG_ADDR : rdata_mux_out = counter_reg;
        CNT_INIT_REG_ADDR : rdata_mux_out = count_init;
        CNT_MIN_REG_ADDR : rdata_mux_out = count_min;
        CNT_MAX_REG_ADDR : rdata_mux_out = count_max;
        CNT_REG_MATCH_1_ADDR : rdata_mux_out = cnt_match_1_reg;
        CNT_REG_MATCH_0_ADDR : rdata_mux_out = cnt_match_0_reg;
        default: rdata_mux_out = 8'b0;
    endcase
end
assign rdata = rdata_mux_out & {8{rd_en}};


endmodule

module timer_registers(
           input   logic      clk,
           rst,
           module_en,
           wr,
           logic [7:0]  wdata,
           logic [5:0]  addr,
           output  logic [7:0]  rdata,

           //register control
           output logic overflow_int_en,
           output logic out_match_1_int_en,
           output logic out_match_0_int_en,
           output logic clock_select,
           output logic [2:0] operation_mode,
           output logic start


       );

localparam CTRL_REG_RST  = 8'h0;
localparam CNT_REG_RST   = 8'h0;
localparam STATUS_REG_RST  = 8'h0;
localparam CNT_REG_MATCH_1_RST  = 8'h0;
localparam CNT_REG_MATCH_2_RST  = 8'h0;


localparam CTRL_REG_ADDR = 8'h0;
localparam STATUS_REG_ADDR = 8'h1;
localparam CNT_REG_ADDR  = 8'h2;
localparam CNT_REG_MATCH_1_ADDR  = 8'h3;
localparam CNT_REG_MATCH_2_ADDR = 8'h4;


wire ctrl_reg_sel = (addr == CTRL_REG_ADDR);
wire cnt_reg_sel = (addr == CNT_REG_ADDR);
wire status_reg_sel = (addr == STATUS_REG_ADDR);
wire cnt_match_1_sel = (addr == CNT_REG_MATCH_1_ADDR);
wire cnt_match_2_sel = (addr == CNT_REG_MATCH_2_ADDR);

wire         wr_en;
wire         rd_en;
logic [7:0]  rdata_mux_out;


assign wr_en = module_en &  wr;
assign rd_en = module_en & ~wr;


logic [7:0] ctrl_reg;

assign ctrl_reg = {
           start,
           operation_mode,
           clock_select,
           out_match_0_int_en,
           out_match_1_int_en,
           overflow_int_en,
           1'b0
       };


always @(posedge clk or posedge rst)
begin
    if (rst)
        start = CTRL_REG_RST[7];
    else
        if (wr_en & ctrl_reg_sel)
            start = wdata[7];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        operation_mode = CTRL_REG_RST[6:5];
    else
        if (wr_en & ctrl_reg_sel)
            operation_mode = wdata[6:5];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        clock_select = CTRL_REG_RST[4];
    else
        if (wr_en & ctrl_reg_sel)
            clock_select = wdata[4];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_0_int_en = CTRL_REG_RST[3];
    else
        if (wr_en & ctrl_reg_sel)
            out_match_0_int_en = wdata[3];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        out_match_1_int_en = CTRL_REG_RST[2];
    else
        if (wr_en & ctrl_reg_sel)
            out_match_1_int_en = wdata[2];
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        overflow_int_en = CTRL_REG_RST[1];
    else
        if (wr_en & ctrl_reg_sel)
            overflow_int_en = wdata[1];
end

//register count
logic [7:0] counter;
logic [7:0] counter_reg;

always @(posedge clk or posedge rst)
begin
    if (rst)
        counter = CNT_REG_RST;
    else
        if (wr_en & cnt_reg_sel)
            counter = wdata;

end

assign counter_reg = counter;

//register status

logic [7:0] status;
logic [7:0] status_reg;

always @(posedge clk or posedge rst)
begin
    if (rst)
        status = STATUS_REG_RST;
    else
        if (wr_en & status_reg_sel)
            status = wdata;

end

assign status_reg = status;


//register output match_1 value
logic [7:0] cnt_match_1;
logic [7:0] cnt_match_1_reg;

always @(posedge clk or posedge rst)
begin
    if (rst)
        cnt_match_1 = CNT_REG_MATCH_1_RST;
    else
        if (wr_en & cnt_match_1_sel)
            cnt_match_1 = wdata;
end

assign cnt_match_1_reg = cnt_match_1;

//register output match_2 value
logic [7:0] cnt_match_2;
logic [7:0] cnt_match_2_reg;

always @(posedge clk or posedge rst)
begin
    if (rst)
        cnt_match_2 = CNT_REG_MATCH_2_RST;
    else
        if (wr_en & cnt_match_2_sel)
            cnt_match_2 = wdata;

end

assign cnt_match_2_reg = cnt_match_2;


//read register

always @ (*)
begin : MUX
    case(addr )
        CTRL_REG_ADDR : rdata_mux_out = ctrl_reg;
        CNT_REG_ADDR : rdata_mux_out = counter_reg;
        STATUS_REG_ADDR : rdata_mux_out = status_reg;
        CNT_REG_MATCH_1_ADDR : rdata_mux_out = cnt_match_1_reg;
        CNT_REG_MATCH_2_ADDR : rdata_mux_out = cnt_match_2_reg;
        default: rdata_mux_out = 8'b0;
    endcase
end


assign rdata = rdata_mux_out & {8{rd_en}};

endmodule

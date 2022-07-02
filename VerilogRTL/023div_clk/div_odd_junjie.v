module div_odd_junjie (
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);


reg [2:0] cnt;
reg clk_p, clk_n;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt <= 0;
    end
    else begin
        if (cnt == 4) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        clk_p <= 0;
    end
    else begin
        if (cnt == 2 || cnt == 4) begin
            clk_p <= ~clk_p;
        end
        else begin
            clk_p <= clk_p;
        end
    end
end

//50%占空比
always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        clk_n<= 0;
    end
    else begin
        clk_n <= clk_p;
    end
end
//assign div_clk = clk_n | clk_p;
wire duty50 =  clk_n | clk_p;

//%更多占空比 70%
reg [1:0] mclk_n;
always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
         mclk_n<= 0;
    end
    else begin
         mclk_n <= { mclk_n[0], clk_p};
    end
end
assign div_clk = mclk_n[1] | clk_p;

//%更少的占空比 30%
//减少clkp的时间来减少占空比,增加clkp也能增加占空比
reg mclk_p;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        mclk_p <= 0;
    end
    else begin
        if (cnt == 2 || cnt == 3) begin
            mclk_p <= ~mclk_p;
        end
        else begin
            mclk_p <= mclk_p;
        end
    end
end
reg clk_n30;
always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        clk_n30<= 0;
    end
    else begin
        clk_n30 <= mclk_p;
    end
end
wire duty30 =  clk_n30 | mclk_p;

endmodule
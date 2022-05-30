
//倍数的时钟使用这个一级的D触发器
module ChangeTimesClk(
    input  wire clk1,
    input  wire clk0,
    input  wire select,
    input  wire rst_n,
    output  wire outclk 
);

reg out1;
reg out0;
always @(posedge clk1 or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        out1 <= 0;
    end
    else begin
        out1 <= ~out0 & ~select; 
    end
end
always @(posedge clk0 or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        out0 <= 0;
    end
    else begin
        out0 <= ~out1 & select;
    end
end

assign outclk = (out1&clk1) | (out0&clk0);

endmodule
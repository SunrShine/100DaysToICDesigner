module dff2(
    input  wire clk1,
    input  wire clk0,
    input  wire select,
    input  wire rst_n,
    output  wire out00, out01,
    output wire outclk 
);

reg out1;
reg out0;
always @(negedge clk1 or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        out1 <= 0;
    end
    else begin
        out1 <= ~out0 & ~select; 
    end
end
always @(negedge clk0 or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        out0 <= 0;
    end
    else begin
        out0 <= ~out1 & select;
    end
end

assign  out00 = out0;
assign  out01 = out1;

assign outclk = (out1&clk1) | (out0&clk0);

endmodule
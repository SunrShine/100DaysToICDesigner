module Change_Clk_Source(
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
        out
    end
end

endmodule
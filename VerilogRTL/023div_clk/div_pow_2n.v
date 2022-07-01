//偶数分频


module div_pow_2n(
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);

reg clk_2, clk_4;

always @(posedge clk or negedge rst_n) begin
    if( !rst_n)begin
        clk_2 <= 0;
    end
    else begin
        clk_2 <= ~clk_2;
    end
end

always @(posedge clk_2 or negedge rst_n) begin
    if( !rst_n)begin
        clk_4 <= 0;
    end
    else begin
        clk_4 <= ~clk_2;
    end
end

assign div_clk = clk_4;

endmodule
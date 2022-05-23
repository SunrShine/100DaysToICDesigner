module top_level(
    input wire  clk_slow,
    input wire  clk_fast,
    input wire  rst_n,
    input wire  signal_in,
    output wire signal_out,

    input wire type
);


reg [1:0] signal_inAll; 

wire [1:0] signal_outAll; //输出一般是wire

Clk_SlowToFast SlowToFast1(
    .clk_slow(clk_slow),
    .clk_fast(clk_fast),
    .rst_n(rst_n),
    .signal_in(signal_inAll[0]),
    .signal_out(signal_outAll[0])
);
Clk_SlowToFast_clap SlowToFast2(
    .clk_slow(clk_slow),
    .clk_fast(clk_fast),
    .rst_n(rst_n),
    .signal_in(signal_inAll[1]),
    .signal_out(signal_outAll[1])
);



always @(*) begin
    if(type == 1'b0)begin
        signal_inAll <= {1'b0, signal_in};
    end
    else 
        signal_inAll <= {signal_in, 1'b0};
end

assign signal_out = type ? signal_outAll[1] : signal_outAll[0];

endmodule
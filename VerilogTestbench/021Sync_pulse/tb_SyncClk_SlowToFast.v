
`default_nettype none

module tb_SyncClk_SlowToFast;

reg clk_fast, clk_slow;
reg rst_n;
reg signal_in; 
wire signal_out;

SyncClk_SlowToFast tb
(
    .clk_slow(clk_slow),
    .clk_fast(clk_fast),
    .rst_n (rst_n),
    .signal_in(signal_in),
    .signal_out(signal_out)
);


localparam clk_fast_PERIOD = 10;
localparam clk_slow_PERIOD = 20;
always #(clk_fast_PERIOD/2) clk_fast=~clk_fast;
always #(clk_slow_PERIOD/2) clk_slow=~clk_slow;

// initial begin
//     $dumpfile("tb_SyncClk_SlowToFast.vcd");
//     $dumpvars(0, tb_SyncClk_SlowToFast);
// end

initial begin
    //初始化
    clk_fast<=1'b0;
    clk_slow<=1'b0;
    signal_in <= 1'b0;
    rst_n<=1'bx;
    #(clk_fast_PERIOD*2) rst_n<=1;
    
    #(clk_slow_PERIOD*2) signal_in <= 1;
    #(clk_slow_PERIOD) signal_in <= 0;

    #(clk_slow_PERIOD*3)$stop;
end

endmodule
`default_nettype wire


//modelsim仿真命令
//vlog .\tb_SyncClk_SlowToFast.v ..\..\VerilogRTL\021Sync_Pulse\SyncClk_SlowToFast.v
//vsim .\tb_SyncClk_SlowToFast.v -voptargs=+acc

`default_nettype none

module tb_SyncClk_FastToSlow;

reg clk_fast, clk_slow;
reg rst_n;
reg signal_in; 
wire signal_out;

SyncClk_FastToSlow tb
(
    .clk_slow(clk_slow),
    .clk_fast(clk_fast),
    .rst_n (rst_n),
    .signal_in(signal_in),
    .signal_out(signal_out)
);

localparam clk_fast_PERIOD = 10;
localparam clk_slow_PERIOD = 30;
always #(clk_fast_PERIOD/2) clk_fast=~clk_fast;
always #(clk_slow_PERIOD/2) clk_slow=~clk_slow;

initial begin
    //初始化
    clk_fast<=1'b0;
    clk_slow<=1'b0;
    signal_in <= 1'b0;
    rst_n<=1'bx;
    //开始使能，（结束reset）
    #(clk_fast_PERIOD*2) rst_n<=1;
    

    #(clk_fast_PERIOD*5) signal_in <= 1;
    #(clk_fast_PERIOD) signal_in <= 0;

    #(clk_slow_PERIOD*3)$stop;
end

endmodule
`default_nettype wire

//modelsim仿真命令
//vlib work 建立工作目录“一次就行了”
//vlog .\tb_SyncClk_FastToSlow.v ..\..\VerilogRTL\021Sync_Pulse\SyncClk_FastToSlow.v
//vsim .\tb_SyncClk_FastToSlow.v -voptargs=+acc
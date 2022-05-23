module SyncClk_SlowToFast_clap(

    input wire clk_slow,//异步慢时钟
    input wire clk_fast,//目的快时钟域市政
    input wire rst_n,   //复位信号
    input wire signal_in, //异步信号

    output wire signal_out


    ); //快时钟域同步后的信号

reg [2:0]    sig_r;   //3级缓存，前两级用于同步，后两节用于边沿检测

always @(posedge clk_fast or negedge rst_n) begin
    if (!rst_n)
         sig_r  <= 3'b0 ;
    else      
        sig_r  <= {sig_r[1:0], signal_in} ;  //缓存
end

assign signal_out = sig_r[1] && !sig_r[2] ; //上升沿检测

endmodule
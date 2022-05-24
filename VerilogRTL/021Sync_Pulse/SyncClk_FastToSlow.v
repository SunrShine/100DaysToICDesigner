//
module SyncClk_FastToSlow (
    input wire clk_slow,
    input wire clk_fast,
    input wire rst_n,

    input wire signal_in,
    output wire signal_out
);

reg signal_in_widen ;
reg signal_out_reg ;
reg [1:0] signal_out_posedge ;


//把快时钟域的控制信号根据进行延长合适的时间
always @(posedge clk_fast or negedge rst_n) begin


    //根据输入拉高延长的信号
    if(rst_n == 1'b0)begin
        signal_in_widen <= 1'b0;
    end
    else if(signal_in == 1'b1)begin
        signal_in_widen <= 1'b1;
    end

    
    //将延长信号拉低
    else if(signal_out_posedge[1] == 1'b1)
        signal_in_widen <= 1'b0;
    else
        signal_in_widen <= signal_in_widen;
end


//在慢时钟域生成信号
always @(posedge clk_slow or negedge rst_n) begin
    if(rst_n == 1'b0)begin
        signal_out_reg <= 1'b0;
    end
    else begin
        signal_out_reg <= signal_in_widen;
    end
end
assign signal_out = signal_out_reg;

//在clk_fast下提取慢时钟的信号上升沿作
always @(posedge clk_fast or negedge rst_n) begin
    if(rst_n == 1'b0)begin
        signal_out_posedge <= 1'b0;
    end
    else
        signal_out_posedge <= {signal_out_posedge[0], signal_out};
        
end


endmodule
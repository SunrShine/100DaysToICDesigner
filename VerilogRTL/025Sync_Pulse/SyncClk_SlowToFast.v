//慢时钟域到快时钟域使用两级触发器
module SyncClk_SlowToFast (
    input wire clk_slow,
    input wire clk_fast,
    input wire rst_n,
    input wire signal_in,
    output wire signal_out
);
    reg [1:0] signal_temp;
    always @(posedge clk_fast or negedge rst_n) begin
        if (~rst_n) begin
            signal_temp <= 2'b00;
        end
        else begin
            signal_temp <= {signal_temp[0], signal_in};
        end
    end

    assign signal_out = signal_temp[1];
endmodule
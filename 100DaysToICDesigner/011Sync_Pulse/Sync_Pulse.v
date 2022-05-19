module Sync_Pulse (
    input  wire  clka,
    input  wire  clkb,
    input  wire  rst_n,
    input  wire  pulse_ina,
    output wire  pulse_outb,
    output wire  signal_outb
);

//------------
reg signal_a;
reg signal_b;

reg [1:0] signal_a_r; //返回拉低a，表示信号转换完成。
reg [1:0] signal_b_r;

always @(posedge clka or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        signal_a <= 1'b0;
    end
    else if (pulse_ina) begin
        signal_a <= 1'b1;
    end
    else if (signal_a_r[1] == 1'b1) begin
        signal_a <= 1'b0;
    end
    else 
        signal_a <= signal_a;
end

always @(posedge clkb or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        signal_b <= 1'b0;
    end
    else 
        signal_b <= signal_a;

end

always @(posedge clkb or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        signal_b_r <= 2'b00;
    end
    else 
        signal_b_r <= {signal_b_r[0], signal_b};
end
assign pulse_outb = ~signal_b_r[1] & signal_b_r[0]; //检测上升沿
assign signal_outb = signal_b_r[1];


//生成拉低反馈
always @(posedge clka or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        signal_a_r <= 2'b00;
    end
    else begin
        signal_a_r <= {signal_a_r[0], signal_b_r[1]};
    end
end


endmodule //Sync_Pulse Sync_Pulse
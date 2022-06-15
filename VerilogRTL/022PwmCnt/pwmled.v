module pwmled(
    input wire clk,
    input wire rst_n,
    output wire led_out
);
parameter Delay24 = 24;
parameter Delay100 = 100;
    
wire delay_1us, delay_1ms, delay_1s;
reg pwm;
reg [5:0] cnt1;
reg [10:0] cnt2, cnt3;
reg display_state;


//1us
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt1 <= 6'b0;
    else if(cnt1 == DELAY24 - 1'b1)
        cnt1 <= 6'b0;
    else
        cnt1 <= cnt1 + 1'b1;
end
assign delay_1us = (cnt1 == DELAY24 - 1'b1)? 1'b1:1'b0;

//1ms
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt2 <= 10'b0;
    else if(delay_1us == 1'b1)begin
    if(cnt2 == DELAY1000 - 1'b1)
        cnt2 <= 10'b0;
    else
        cnt2 <= cnt2 + 1'b1;
    end
    else
        cnt2 <= cnt2;
end
assign delay_1ms = ((delay_1us == 1'b1) && (cnt2 == DELAY1000 - 1'b1))?
1'b1:1'b0;


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        display_state <= 1'b0;
    else if(delay_1ms)//每1ms切换一次led灯显示状态
        display_state <= ~display_state;
    else
        display_state <= display_state;
end





endmodule
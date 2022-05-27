// 根据图statecircuit2.png列出真值表，画出卡诺图，
// 计算出来状态转移方程：(^{} 表示上标 )
// Q1^{n+1} = Q0^{n} * ~C + Q1^{n} * C
// Q0^{n+1} = ~Q1^{n} * C + Q0^{n} * ~C
// Y = Q1^{n} * C + Q1^{n} * Q0^{n} * ~C

module statecircuit2(
    input    wire   C   ,
    input    wire   clk ,
    input    wire   rst_n,

    output   wire   Y  
);
    reg Q0, Q1;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            Q1 <= 0;
        end
        else begin
            Q1 <= (Q0 & ~C) | (Q1 & C);
        end
    end
    always@(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            Q0 <= 0;
        end
        else begin
            Q0 <= (~Q1 & C) | (Q0 & ~C);
        end
    end
    assign Y = (Q1 & C) | (Q1 & Q0 & ~C);
    
endmodule
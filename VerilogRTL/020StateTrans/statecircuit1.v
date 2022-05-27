

// 根据图statecircuit1.png得出电路状态转移方程：
// Q1n+1 = A ⊕ Q1n ⊕ Q0n
// Q0n+1= ~Q0n
// Y=Q0n ⋅ Q1n

 module statecircuit1(
    input    wire   A   ,
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
            Q1 <= A ^ Q0 ^ Q1;
        end
    end
    always@(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            Q0 <= 0;
        end
        else begin
            Q0 <= ~Q0;
        end
    end
    assign Y = Q0 & Q1;
endmodule



//代码片段模板：两个d触发器和组合逻辑电路：
// reg Q0, Q1;
// always @(posedge clk or negedge rst_n) begin
//     if (~rst_n) begin
//         Q1 <= 0;
//     end
//     else begin
//         Q1 <= ;
//     end
// end
// always@(posedge clk or negedge rst_n) begin
//     if(~rst_n) begin
//         Q0 <= 0;
//     end
//     else begin
//         Q0 <= ;
//     end
// end
// assign Y = ;

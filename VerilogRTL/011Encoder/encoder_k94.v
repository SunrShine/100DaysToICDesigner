`include "Encoder_94.v"

//使用优先编码器现键盘编码电路,
//10个按键分别对应十进制数0-9，按键9的优先级别最高；
//按键悬空时，按键输出高电平，按键按下时，按键输出低电平；
//键盘编码电路的输出是8421BCD码。
//键盘编码电路要有工作状态标志，以区分没有按键按下和按键0按下两种情况。

module encoder_k94 (
    input wire [9:0] S_n,
    output wire [3:0] Num,
    output wire isWork   
);

    wire [3:0] temp;
    Encoder_94 encodek94(
        .I_n(S_n[9:1]),
        .Y_n(temp)
    );
    //对于temp进行缩位与
    assign isWork = ~( (&(~temp)) & S_n[0] );
    assign Num = ~temp;  //按位取反
endmodule
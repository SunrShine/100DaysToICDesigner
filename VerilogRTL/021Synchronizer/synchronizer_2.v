/*
亚稳态：是指触发器无法在某个规定时间段内达到一个确定的状态。
原因：由于触发器的Tsu和Th不满足，当触发器进入亚稳态，使得无法预测该单元的输出，这种不稳定
是会沿信号通道的各个触发器级联传播。
消除：两级或多级寄存器同步。理论上亚稳态不能完全消除，只能降低，一般采用两级触发器同步就可
以大大降低亚稳态发生的概率，再加多级触发器改善不大。
*/

//两级的同步器，
module synchronizer_2(
    input wire d,
    output wire out
);
    reg [1:0] data;
    always @(posedge clk or negedge rst_n) begin
        if (rst_n) begin
            data <= 2'b00;
        end
        else begin
            data <= {data[0], d};
        end
    end
endmodule
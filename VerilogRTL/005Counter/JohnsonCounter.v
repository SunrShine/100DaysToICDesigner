module JohnsonCounter(
    input wire clk,
    input wire rst_n,
    output reg [3:0] johnson_counter
);

// 约翰逊(Johnson)计数器 环形计数器
//

always @(posedge clk or)begin
    if(rst_n == 1'b0)
        johnson_cnt <= 4'b0000;
    else
        johnson_cnt <= {~johnson_cnt[0], johnson_cnt[3:1]};
end
endmodule
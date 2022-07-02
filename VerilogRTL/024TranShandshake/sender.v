module sender #(parameter N = 8;)
(
    input wire clk_t,clk_r; //发送和接受时钟
    input wire rst, start;

    input wire [N-1 : 0]  data_in, 
    output wire [N-1 : 0] data_out,

    output wire valid;
);

//输入开始信号置入寄存器
reg start_reg;
always @(posedge clk_t or negedge rst) begin
    if (~rst) begin
        start_reg <= 0;
    end
    else begin
        start_reg <= start;
    end
end


endmodule
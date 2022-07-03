module data_receiver #(parameter N = 4)
(
    input wire clkb,
    input wire rst_n,

    input wire data_req,
    input wire [N-1:0] data,
    output wire data_ack
);

//检测req上升沿，
reg [1:0] data_req_posedge_reg;
always @(posedge clkb or negedge rst_n) begin
    if (~rst_n) begin
        data_req_posedge_reg <= 2'b0;
    end
    else begin
        data_req_posedge_reg <= {data_req_posedge_reg[0], data_req};
    end
end
wire data_req_posedge = data_req_posedge_reg[0] && ~data_req_posedge_reg[1];

//根据输入的req信号将输出的ack信号置1
reg data_ack_reg;
always @(posedge clkb or negedge rst_n) begin
    if (~rst_n) begin
        data_ack_reg <= 0;
    end
    else if (data_req_posedge) begin
        data_ack_reg <= 1;
    end
    else begin
        data_ack_reg <= 0;
    end
end

//将输入的数据存入寄存器
reg [N-1:0] data_reg;
always @(posedge clkb or negedge rst_n) begin
    if (~rst_n) begin
        data_reg <= 0;
    end
    else if(data_req_posedge)begin
        data_reg <= data;
    end
    else begin
        data_reg <= data_reg;
    end
end


assign data_ack = data_ack_reg;
endmodule //data_receiver
module data_sender #(parameter N = 4)
(
    input wire clka,
    input wire rst_n,
    input wire data_ack,

    output wire data_req,
    output wire [N-1:0] data
);

//检测ack信号上升沿，
reg [1:0] data_ack_posedge_reg;
always @(posedge clka or negedge rst_n) begin
    if (~rst_n) begin
        data_ack_posedge_reg <= 0;
    end
    else begin
        data_ack_posedge_reg <= {data_ack_posedge_reg[0], data_ack};
    end
end
wire data_ack_posedge = data_ack_posedge_reg[0] && ~data_ack_posedge_reg[1];

//根据ack信号进行数据更新ack信号上升沿到来之前保持data不变；
reg [N-1:0] data_output;
always @(posedge clka or negedge rst_n) begin
    if (~rst_n) begin
        data_output <= 0;
    end
    else if(data_ack_posedge) begin
        data_output <= data_output +1; 
    end
    else begin
        data_output <= data_output;
    end
end

//在数据传输完成后间隔5个时钟再进行下一个数据的传输
reg [3:0] cnt;
always @(posedge clka or negedge rst_n) begin
    if (~rst_n) begin
        cnt <= 0;
    end
    else if(data_ack_posedge) begin
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

//根据cnt的值拉高data_req信号，并根据ack的上升沿设置复位为零 
reg data_req_reg;
always @(posedge clka or negedge rst_n) begin
    if (~rst_n) begin
        data_req_reg <= 0;
    end
    else if(cnt == 3'd4) begin
        data_req_reg <= 1'b1;
    end
    else if(data_ack_posedge) begin
        data_req_reg <= 1'b0;
    end
    else begin
        data_req_reg <= data_req_reg;
    end
end

assign data_req = data_req_reg;
assign data = data_output;

endmodule //data_sender
module pingpang(
    input clk,
    input rst_n,
    input[7:0] din,
    output reg[7:0] dout
);

reg [7:0] buffer0 [255:0];
reg [7:0] buffer1 [255:0];

reg wr_flag, rd_flag; //0,1表示读取对应的寄存器；

reg [1:0] curr_state, next_state;

parameter s0 = 2'b01;
parameter s0 = 2'b10;
parameter s0_pos = 1'd0;
parameter s1_pos = 1'd1;

reg[7:0] count; //一般缓冲周期位256个时钟周期
always @(posedge clk ) begin
    if (!rst_n) begin
        count <= 0;
    end
    else begin
        count <= count + 1;
    end
end

always @(posedge clk ) begin
    if (!rst_n) begin
        curr_state <= s0;
    end
    else begin
        curr_state <= next_state;
    end
end

//读写状态机
always @(*) begin
    if (!rst_n) begin
        next_state = s0;
    end
    else begin
        case (1'b1)
            curr_state[s0_pos]:next_state=(count == 8'hFF)?s1:s0; //缓冲周期位256个时钟周期
            curr_state[s1_pos]:next_state=(count == 8'hFF)?s0:s1; //缓冲周期位256个时钟周期
            default:next_state = s0;
        endcase
    end
end
always @(posedge clk)begin
    if(rst)begin
        wr_flag <= 1'd0;
        rd_flag <= 1'd0;
    end
    else begin
        case(1'b1)
            curr_state[s0_pos]:begin
                wr_flag <= 1'd0;//写0读1
                rd_flag <= 1'd0;
            end
            curr_state[s1_pos]:begin
                wr_flag <= 1'd1;//写1读0
                rd_flag <= 1'd1;
            end
            default:begin
                wr_flag <= 1'd0;//写0读1
                rd_flag <= 1'd0;
            end
        endcase
    end
end

//写
always @(posedge clk) begin
    if(rst) begin
    buffer0[count] <= 8'd0;
    buffer1[count] <= 8'd0;
    end
    else begin
        case(wr_flag)
            1'd0:buffer0[count] <= din;//写0
            1'd1:buffer1[count] <= din;//写1
            default:begin
                buffer0[count] <= 8'd0;
                buffer1[count] <= 8'd0;
            end
        endcase
    end
end

//读
always @(posedge clk) begin
    if(rst)begin
        dout <= 8'd0;
    end else
    begin
        case(rd_flag)
            1'd0:dout <= buffer1[count];//读1
            1'd1:dout <= buffer0[count];//读0
            default: dout <= 8'd0;
        endcase
    end
end

endmodule
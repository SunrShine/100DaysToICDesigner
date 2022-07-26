
//使用乒乓reg实现128位串行数据转32位并行数据

module pingpang_serial(
    input clk,
    input rst_n,
    input[127:0] din,
    output reg[31:0] dout
);

reg buffer0 [127:0];
reg buffer1 [127:0];
reg write_flag, read_flag; //0,1表示读取对应的寄存器；
reg [1:0] cnt;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        write_flag <= 0;
        read_flag <= 1;
    end
    else if(cnt == 2'b11) begin
        write_flag <= ~write_flag;
        read_flag  <= ~read_flag;
    end
end

//写
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        buffer0 <= 128'd0;
        buffer1 <= 128'd0;
    end
    else begin
        case(write_flag)
            1'b0:buffer0 <= din;//写buffer0
            1'b1:buffer1 <= din;//写buffer1
            default:begin
                buffer0 <= 128'd0;
                buffer1 <= 128'd0;
            end
        endcase
    end
end

//读
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        dout <= 0;
    end
    else begin
        case (read_flag)
            1'b0: dout <= buffer0[cnt*32-1 : (cnt-1)*32];
            1'b1: dout <= buffer1[cnt*32-1 : (cnt-1)*32];
            default: dout <= 32'd0;
        endcase
    end
end
endmodule
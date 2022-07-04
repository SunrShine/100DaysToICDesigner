/*
设计一个模块进行并串转换，要求每四位d输为转到一位dout输出，输出valid_in表示此时的输入有效
clk为时钟
rst为低电平复位
valid_in 表示输入有效
d 信号输入
dout 信号输出
*/

module huawei5(
	input wire clk  ,
	input wire rst  ,
	input wire [3:0]d ,
	output wire valid_in ,
	output wire dout
	);

//*************code***********//
    reg [1:0] cnt;
    reg [3:0] dout_reg;     
    reg valid_reg;

    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            valid_reg <= 0;
            dout_reg <= 0;
            cnt <= 0;
        end
        else begin
            if(cnt == 2'b11)begin
                valid_reg <= 1;
                dout_reg <= d;
                cnt <= 2'b00;
            end
            else begin
                valid_reg <= 0;
                dout_reg <= {dout_reg[2:0], dout_reg[3]};
                cnt <= cnt + 1;
            end
        end
    end
    assign valid_in = valid_reg;
    assign dout = dout_reg[3];
//*************code***********//

endmodule
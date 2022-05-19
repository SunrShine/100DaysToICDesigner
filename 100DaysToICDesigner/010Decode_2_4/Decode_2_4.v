module Decode_2_4(
    input wire [1:0] indata,
    input wire  enable_n,
    output wire [3:0] outdata
);

/* 注意wire和reg
always @(*)begin
    if(enable_n == 1'b1)
        outdata = 4'b1111;
    else begin
        case(indata)

            //题目：设计BCD译码器，输入0~9。
            //BCD译码器也称为4-10线译码器
            2'b00: outdata = 4'b1110;
            2'b01: outdata = 4'b1101;
            2'b10: outdata = 4'b1011;
            2'b11: outdata = 4'b0111;
        endcase
    end
end
*/

assign outdata[3] = ~(indata[1] & indata[0] & ~enable_n);
assign outdata[2] = ~(indata[1] & ~indata[0] & ~enable_n);
assign outdata[1] = ~(~indata[1] & indata[0] & ~enable_n);
assign outdata[0] = ~(~indata[1] & ~indata[0] & ~enable_n);

endmodule  //注意***>：输出低电平有效，复位低电平有效
module fullSuber_1(
    input wire a,   //被减数
    input wire b,   //减数
    input wire c_in,  //前位借位

    output wire diff,  //减法差值输出
    output wire s_out //减法借位标志输出
);
    //门级电路实现。（组合逻辑）
    assign diff =((~a) & (~b) & (c_in)) | ((~a) & (b) & (~c_in))
                | ((a) & (~b) & (~c_in)) | ( (a) & (b) & (c_in));

    assign s_out = ((~a) & (~b) & (c_in)) | ((~a) & b) | (b & c);

endmodule
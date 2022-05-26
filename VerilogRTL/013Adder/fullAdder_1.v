module fullAdder_1(
    input wire a, b, //两个一位加数字
    input wire c_i,  //进位输入

    output s, c_out
);
    assign s = a ^ b ^ c_i;
    assign c_out = a & b | (a ^ b) & c_i;
endmodule
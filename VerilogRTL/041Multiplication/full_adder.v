module full_adder(
    input wire a, b, //两个一位加数字
    input wire c_in,  //进位输入

    output s, c_out
);
    assign s = a ^ b ^ c_in;
    assign c_out = a & b | (a ^ b) & c_in;
endmodule


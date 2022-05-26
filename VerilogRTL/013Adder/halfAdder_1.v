module halfAdder_1(
    input wire a, b,
    output wire s, c_out
);
    ///没有进位输入，
    assign s = a ^ b;
    assign c_out = a & b;
endmodule
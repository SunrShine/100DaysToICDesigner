module rcax #(
    parameter width = 4
) (
    input [width-1:0] A,
    input [width-1:0] B,
    input wire c_i, 

    output [width-1:0] S,
    output c_o
);
    //把全加器级联起来就构成了 行波进位加法器， 优缺点：。。。

    wire [width:0] cascadeLine; //全加器之间的级联线路
    genvar i;
    generate
        for (i=0; i<width; i=i+1) begin : rca_width
            fullAdder_1 fulladders(
                .a(A[i]),
                .b(B[i]),
                .c_i(cascadeLine[i]),
                .s(S[i]),
                .c_o(cascadeLine[i+1])
            );
        end
    endgenerate

    assign c_o = cascadeLine[width];
    assign cascadeLine[0] = c_i;
    
endmodule

module fullAdder_1(
    input wire a, b, //两个一位加数字
    input wire c_i,  //进位输入

    output s, c_o
);
    assign s = a ^ b ^ c_i;
    assign c_o = a & b | (a ^ b) & c_i;
endmodule

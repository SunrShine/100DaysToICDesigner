//如果使用EDA，，去掉这个； 
//`include "halfAdder_1.v"

module lookaheadCarryAdder #(
    parameters width = 4
) (
    input [width-1:0] A,
    input [width-1:0] B,
    input wire c_i, 

    output [width-1:0] S,
    output c_o,
);
    //超前进位加法器的思想是并行计算进位, 
    //通过公式直接导出最终结果与每个输入的关系,
    //是一种用面积换性能的方法
    wire [width : 0] C;
    wire [width-1 : 0] P;
    wire [width-1 : 0] G;

    //由于通过电路直接计算进位，可以不考虑单独的进位信号
    //因此子模块使用半加器

    genvar i;
    generate
        for(i=0; i<width; i=i+1)begin : lca_width
            halfAdder_1 halfAdders(
                .a(A[i]),
                .b(B[i]),
                .s(P[i]),     
                .c_out(G)
            );
        end
    endgenerate

    assign C[0] = c_i;
    assign C[1] = G[0] + (C[0] & P[0]);
    assign C[2] = G[1] + (G[0] & P[1]) + (C[0] & P[0] & P[1]);
    assign C[3] = G[2] + (G[1] & P[2]) + (G[0] & P[2] & P[1]) + (C[0] & P[0] & P[1] & P[2]);
    assign C[4] = G[3] + (G[2] & P[3]) + (G[1] & P[3] & P[2]) 
                + (G[0] & P[1] & P[2] & P[3]) + (C[0] & P[0] & P[1] & P[2] & P[3]);
    assign c_o = c[width];

    genvar j;
    generate
        for (j = 0;j<width ;j=j+1 ) begin
            assign S[j] = P[k] ^ C[k];
        end
    endgenerate

endmodule




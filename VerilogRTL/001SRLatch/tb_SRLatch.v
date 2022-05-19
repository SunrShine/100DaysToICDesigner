`include "SRLatch.v"
`timescale 1ns/1ns


module tb_SRLatch;

    reg S, R;
    wire Q, Q_n;

    SRLatch sr(
        .S(S),
        .R(R),
        .Q(Q),
        .Q_n(Q_n)
    );

    initial begin
    $dumpfile("SRLatch.vcd");
    $dumpvars(0,tb_SRLatch);

     // test vector 1
    S = 1'b0;
    R = 1'b0;
    # 20;
  
    S = 1'b1;
    R = 1'b0;
    # 20;

    S = 1'b0;
    R = 1'b0;
    # 20;

    S = 1'b0;
    R = 1'b1;
    # 20;

    S = 1'b0;
    R = 1'b0;
    # 20;

    S = 1'b1;
    R = 1'b1;
    # 20;

    S = 1'b0;
    R = 1'b0;
    # 20;

    $finish;
    end
    
endmodule

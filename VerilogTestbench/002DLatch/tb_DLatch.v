`include "DLatch.v"
`timescale 1ns/1ns


module tb_DLatch;

    reg  D, C;
    wire Q, Q_n;

    DLatch sr(
        .D(D),
        .C(C),
        .Q(Q),
        .Q_n(Q_n)
    );

    initial begin
    $dumpfile("DLatch.vcd");
    $dumpvars(0,tb_DLatch);

     // test vector 1
    S = 1'b0;
    R = 1'b0;
    C = 1'b0;
    # 20;

    C = 1'b1;
    # 10

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
//iverlog 运行命令：
// iverilog -o  wave  .\tb_dlatch.v  ..\..\VerilogRTL\002DLatch\DLatch.v
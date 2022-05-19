`include "Edge_Detect.v"
`timescale 1ns/1ns


module tb_Edge_Detect;

    reg clk;
    reg rst_n;
    reg data;

    wire pos_edge, neg_edge, data_edge;

    Edge_Detect edgedetcet(
        .rst_n (rst_n),
        .clk (clk),
        .data(data),
        .pos_edge(pos_edge),
        .neg_edge(neg_edge),
        .data_edge(data_edge)
    );

    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    initial begin
        $dumpfile("tb_Edge_Detect.vcd");
        $dumpvars(0, tb_Edge_Detect);

        



    end

    initial begin
        data = 0;

        #10 rst_n<=1;

        #30 data = 1;

        #(CLK_PERIOD*3);
        data = 0;
        
        #100
        $finish;
    end


endmodule          



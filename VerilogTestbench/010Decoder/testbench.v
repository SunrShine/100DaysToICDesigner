`include "Decode_2_4.v"
`timescale 1ns/1ns

module Decode_2_4_testbench;


    reg [1:0] in1 ;
    reg en_n1 ;
    wire [3:0] out;
    Decode_2_4 decode24(
        .indata(in1),
        .enable_n(en_n1),
        .outdata(out)
    );

    initial begin
    $dumpfile("decode24.vcd");
    $dumpvars(0,Decode_2_4_testbench);

    // test vector 1
    in1 =  2'b00;
    en_n1 =  1'b1;
    # 20;
    in1 =  2'b10;
    en_n1 =  1'b1;
    # 20;

    // test vector
    in1 =  2'b00;
    en_n1 =  1'b0;
    # 20;
    in1 =  2'b01;
    en_n1 =  1'b0;
    # 20;
    in1 =  2'b10;
    en_n1 =  1'b0;
    # 20;
    in1 =  2'b11;
    en_n1 =  1'b0;
    # 20;

    // stop simulation
    $finish;

    end



endmodule
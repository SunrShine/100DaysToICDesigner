`include "DTrigger.v"
`default_nettype none

module tb_DTrigger;
reg clk;
reg data;
wire q;
DTrigger dtrigger
(
    
    .clk (clk),
    .data(data),
    .outq(q)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_DTrigger.vcd");
    $dumpvars(0, tb_DTrigger);

    data<=0;clk<=0; //reg初值

    #11 data <= 1;
    #1 data = 0;

    #21 data = 1;
    #4  data = 0; 

    #100
    $finish;

end


endmodule
`default_nettype wire
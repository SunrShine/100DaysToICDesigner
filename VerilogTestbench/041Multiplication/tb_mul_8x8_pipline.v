module tb_mul_8x8_pipline;

localparam T8 = 5;

reg clk8x8,rst_n;
reg vld_in;

reg [7:0] a, b;
wire [15:0] dout;
wire vld_out;


initial begin
    clk8x8 = 0;
    rst_n = 1;
    vld_in = 0;
    a = 8'b0000_0010;
    b = 8'b0000_1111;

    #10 rst_n = 0;
    #10 rst_n = 1;
    vld_in = 1;
end

always #(T8/2) clk8x8 = ~clk8x8;

mul_8x8_pipline  a1(

    .clk_mul8x8(clk8x8),
    .rst_n(rst_n),
    .a(a),
    .b(b),

    .dout(dout)
 
    );



endmodule 

// vlog .\tb_mul_8x8_pipline.v  ..\..\VerilogRTL\041Multiplication\mul_8x8_pipline.v
// vsim .\tb_mul_8x8_pipline.v 
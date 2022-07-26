module testbench;

localparam T = 20;
//localparam  = ;
localparam width =16;

reg [width-1:0] X;
reg [width-1:0] Y;
wire [2*width-1:0] P;

initial begin
    X = 16'h10;
    Y = 0;
    repeat (20) begin  //重复11次
        #(T) ;
        Y = Y + 1;
    end
end

mul_BaughWooley #(.WIDTH(width)) test_mul01 (
    .X(X),
    .Y(Y),
    .P(P)
);

endmodule


// vlog .\tb_mul_BaughWooley.v ..\..\VerilogRTL\041Multiplication\mul_BaughWooley.v ..\..\VerilogRTL\041Multiplication\full_adder.v ..\..\VerilogRTL\041Multiplication\rca.v 

//  vsim .\tb_mul_BaughWooley.v -voptargs=+acc
module tb_rippleCarryAdder;

localparam WIDTH = 16;

reg  [WIDTH-1:0]  A,B;
wire [WIDTH-1:0] S;
reg  c_i;
wire c_o;


rippleCarryAdder #(
    .width(WIDTH)
) rca_16 (
    .A(A),
    .B(B),
    .c_i(c_i), 

    .S(S),
    .c_o(c_o)
);


initial begin
    A = 1;
    B = 1;
    c_i =1;
    
    repeat(10)begin
        #10 A = A + 10;
    end
end

endmodule

//vlog .\tb_rippleCarryAdder.v .\rippleCarryAdder.v
// vsim .\tb_rippleCarryAdder.v -voptargs=+acc
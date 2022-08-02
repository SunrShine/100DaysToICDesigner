module tb_BW_mul3;
reg [2:0] x1, x2;
wire [5:0] pout;


initial begin
    x1 = 2;
    x2 = 2;

    repeat (3) begin
        #10 x1 = x1 + 2;
    end
end


BW_mul3 mul3 (
    .X(x1),
    .Y(x2),
    .P(pout)
);


endmodule

//  vlog .\tb_BW_mul3.v .\BW_mul3.v .\rcax.v
/// vsim .\tb_BW_mul3.v  -voptargs=+acc
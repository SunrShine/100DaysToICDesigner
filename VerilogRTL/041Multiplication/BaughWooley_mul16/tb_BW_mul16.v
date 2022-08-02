module tb_BW_mul16;

    reg [15:0] x1, x2;
    wire [31:0] pout;

    initial begin
        x1 = 2;
        x2 = 2;

        repeat (5) begin
            #10 x1 = x1 + 10;
        end

        repeat (5) begin
            #10 x1 = x1 - 100;
        end
    end


    BW_mul16 #(
        .WIDTH(16)
    ) mul16 (
        .X(x1),
        .Y(x2),
        .P(pout)
    );







endmodule

//  vlog .\tb_BW_mul16.v .\BW_mul16.v 
/// vsim .\tb_BW_mul16.v  -voptargs=+acc
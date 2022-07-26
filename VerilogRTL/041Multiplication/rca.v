module rca #(parameter WIDTH = 16) (
    input wire [WIDTH-1:0] ad1,
    input wire [WIDTH-1:0] ad2,
    input wire c_in,
    output wire [WIDTH-1:0] s_out,
    output wire c_out
);
    
    wire [WIDTH:0] temp;
    assign temp[0] = c_in;

    genvar i;
    generate
        for(i=0; i<WIDTH; i=i+1)begin : gen_full_adder
            full_adder u_full_adder(
                .a(ad1[i]),
                .b(ad2[i]),
                .c_in(temp[i]),
                .c_out(temp[i+1]),
                .s(s_out[i])
            );
        end
    endgenerate

    assign c_out = temp[WIDTH];

endmodule
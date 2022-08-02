module BW_mul3(
    input [2:0] X,
    input [2:0] Y,
    output [5:0] P
);

    wire xy [2:0][2:0];
    wire si [2:0][2:0];
    wire ci [2:0][2:0];
    wire so [2:0][2:0];
    wire co [2:0][2:0];

///1-xy-ij
//part1
assign xy[0][0] = X[0] & Y[0];
assign xy[0][1] = X[0] & Y[1];
assign xy[1][0] = X[1] & Y[0];
assign xy[1][1] = X[1] & Y[1];

//part2
assign xy[2][0] = ~(X[2] & Y[0]);
assign xy[2][1] = ~(X[2] & Y[1]);

//part3
assign xy[0][2] = ~(X[0] & Y[2]);
assign xy[1][2] = ~(X[1] & Y[2]);

//part4
assign xy[2][2] = X[2] & Y[2];

///2-cij,  sij
//cij
assign ci[0][0] = 1'b0;
assign ci[1][0] = 1'b0;
assign ci[2][0] = 1'b0;

assign ci[0][1] = co[0][0];//
assign ci[0][2] = co[0][1];
assign ci[1][1] = co[1][0];//
assign ci[1][2] = co[1][1];
assign ci[2][1] = co[2][0];//
assign ci[2][2] = co[2][1];

//sij
assign si[0][0] = 1'b0;
assign si[1][0] = 1'b0;
assign si[2][0] = 1'b0;

assign si[2][1] = 1'b0;
assign si[2][2] = 1'b0;

assign si[0][1] = so[1][0];
assign si[0][2] = so[1][1];
assign si[1][1] = so[2][0];
assign si[1][2] = so[2][1];

genvar i,j;
generate
    for (i=0; i<3; i=i+1)begin
        for (j=0; j<3; j=j+1)begin :full_adders
            fullAdder_1 u_full_adder(
                .a      (si[i][j]),
                .b      (xy[i][j]),
                .c_i    (ci[i][j]),
                .c_o    (co[i][j]),
                .s      (so[i][j])
            );
        end
    end
endgenerate


//part5
wire [2:0] rca_ad1, rca_ad2, rca_so;
wire rca_ci, rca_co;

assign rca_ad1[0] = so[1][2];
assign rca_ad1[1] = so[2][2];
assign rca_ad1[2] = 1'b1;

assign rca_ad2[0] = co[0][2];
assign rca_ad2[1] = co[1][2];
assign rca_ad2[2] = co[2][2];

assign rca_ci = 1'b1;

rcax #(
    .width(4)
) rca_16 (
    .A(rca_ad1),
    .B(rca_ad2),
    .c_i(rca_ci), 

    .S(rca_so),
    .c_o(rca_co)
);


assign P[0] = so[0][0];
assign P[1] = so[0][1];
assign P[2] = so[0][2];

assign P[5:3] = rca_so;

endmodule
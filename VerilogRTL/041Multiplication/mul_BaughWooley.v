module mul_BaughWooley #(parameter WIDTH = 16) (
    input wire [WIDTH-1:0] X,
    input wire [WIDTH-1:0] Y,

    output wire [2*WIDTH-1:0] P
);

wire  xy[WIDTH-1:0][WIDTH-1:0]; //
wire  si[WIDTH-1:0][WIDTH-1:0];
wire  ci[WIDTH-1:0][WIDTH-1:0];
wire  so[WIDTH-1:0][WIDTH-1:0];
wire  co[WIDTH-1:0][WIDTH-1:0];


//generate xy
genvar i,j;
//part1
generate
    for (i=0; i<WIDTH-1 ; i=i+1) begin
        for (j=0; j<WIDTH-1 ;j=j+1 ) begin
            assign xy[i][j] = X[i] & Y[j];
        end
    end
endgenerate
//part2
generate
    for (j=0; j<WIDTH-1 ; j=j+1) begin
        assign xy[WIDTH-1][j] = ~(X[WIDTH-1] & Y[j]);
    end
endgenerate
//part3
generate
    for (i=0; i<WIDTH-1 ;i=i+1 ) begin
        assign xy[i][WIDTH-1] = ~(X[i] & Y[WIDTH-1]);
    end
endgenerate
//part4
assign xy[WIDTH-1][WIDTH-1] = X[WIDTH-1] & Y[WIDTH-1];


//ci 和 si
generate
    for (i=0 ;i<WIDTH ;i=i+1 ) begin
        assign ci[i][0] = 1'b0;
    end
    for (i=0 ;i<WIDTH ;i=i+1 ) begin
        for(j=1 ;j<WIDTH ;j=j+1)begin
            assign ci[i][j] = co[i][j-1];
        end
    end
endgenerate

generate
    for (i=0 ;i<WIDTH ;i=i+1 ) begin
        assign si[i][0] = 1'b0;
    end
    for (j=1; j<WIDTH; j=j+1)begin
        assign si[WIDTH-1][j] = 1'b0; 
    end
    for (i=0 ;i<WIDTH-1 ;i=i+1 ) begin
        for(j=1 ;j<WIDTH ;j=j+1)begin
            assign si[i][j] = so[i+1][j-1];
        end
    end
endgenerate

//full_adder
generate
    for (i=0; i<WIDTH; i=i+1)begin
        for (j=0; j<WIDTH; j=j+1)begin :full_adders
            full_adder u_full_adder(
                .a      (si[i][j]),
                .b      (xy[i][j]),
                .c_in   (ci[i][j]),
                .c_out  (co[i][j]),
                .s      (so[i][j])
            );
        end
    end
endgenerate

//part5 rca adder
wire [WIDTH-1:0] rca_ad1, rca_ad2, rca_so;
wire rca_ci, rca_co;

generate
    for (i=0; i<WIDTH-1; i=i+1)begin
        assign rca_ad1[i] = so[i+1][WIDTH-1];
    end
    assign rca_ad1[WIDTH-1] = 1'b1;
endgenerate

generate
    for (i=0; i<WIDTH; i=i+1)begin
        assign rca_ad2[i] = co[i][WIDTH-1];
    end
endgenerate
assign rca_ci = 1'b1;

rca #(WIDTH) u_rca(
    .ad1    (rca_ad1),
    .ad2    (rca_ad2),
    .c_in   (rca_ci),
    .s_out  (rca_so),
    .c_out  (rca_co)
);

//result output
generate
    for (j=0; j<WIDTH; j=j+1)begin
        assign P[j] = so[0][j];
    end
endgenerate
assign P[2*WIDTH-1 : WIDTH] = rca_so;

endmodule
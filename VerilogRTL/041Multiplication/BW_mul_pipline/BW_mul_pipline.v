module BW_mul_pipline #(parameter WIDTH = 16)
(
    input wire clk,
    input wire rst_n,

    input wire [WIDTH-1:0] X_wire,
    input wire [WIDTH-1:0] Y_wire,

    output wire [2*WIDTH-1:0] P,

    output reg [WIDTH-1:0] mul_out
);

    reg [WIDTH-1:0] X,Y;

    always@(posedge clk or negedge rst_n)begin
        if (!rst_n) begin
            X <= 0;
            Y <= 0;
        end
        else begin
            X <= X_wire;
            Y <= Y_wire;
        end
    end


    wire  xy[WIDTH-1:0][WIDTH-1:0]; //
    wire  si[WIDTH-1:0][WIDTH-1:0];
    wire  ci[WIDTH-1:0][WIDTH-1:0];
    wire  so[WIDTH-1:0][WIDTH-1:0];
    wire  co[WIDTH-1:0][WIDTH-1:0];

    reg [WIDTH-1:0] pipline_so_reg0,  pipline_co_reg0;

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

    //为co， so加入流水线寄存器
    //ci 和 si 
    generate
        for (i=0 ;i<WIDTH ;i=i+1 ) begin
            assign ci[i][0] = 1'b0;
        end
        for (i=0 ;i<WIDTH ;i=i+1 ) begin
            for(j=1 ;j<WIDTH/2 ;j=j+1)begin
                assign ci[i][j] = co[i][j-1];
            end
        end
        for (i=0 ;i<WIDTH ;i=i+1 ) begin
            assign ci[i][WIDTH/2] = pipline_co_reg0[i];  //连接pipline reg

        end

        for (i=0 ;i<WIDTH ;i=i+1 ) begin
            for(j=WIDTH/2+1 ;j<WIDTH ;j=j+1)begin
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
            for(j=1 ;j<WIDTH/2 ;j=j+1)begin
                assign si[i][j] = so[i+1][j-1];
            end
        end

        for (i=0 ;i<WIDTH-1 ;i=i+1 ) begin
            assign si[i][WIDTH/2] = pipline_so_reg0[i+1];
        end

        for (i=0 ;i<WIDTH-1 ;i=i+1 ) begin
            for(j=WIDTH/2+1 ;j<WIDTH ;j=j+1)begin
                assign si[i][j] = so[i+1][j-1];
            end
        end
    endgenerate
    reg [31:0] index; 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pipline_co_reg0 <= 0;
            pipline_so_reg0 <= 0;
            index <= 0;
        end
        else begin
            for (index=0 ;index<WIDTH ;index=index+1 ) begin
                pipline_co_reg0[index] <= co[index][WIDTH/2-1];
                pipline_so_reg0[index] <= so[index][WIDTH/2-1];
            end
        end
    end

    //full_adder
    generate
        for (i=0; i<WIDTH; i=i+1)begin
            for (j=0; j<WIDTH; j=j+1)begin :full_adders
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


    rcax #(
    .width(WIDTH)
    ) rca_16 (
        .A(rca_ad1),
        .B(rca_ad2),
        .c_i(rca_ci), 

        .S(rca_so),
        .c_o(rca_co)
    );


    //result output
    generate
        for (j=0; j<WIDTH; j=j+1)begin
            assign P[j] = so[0][j];
        end
    endgenerate
    assign P[2*WIDTH-1 : WIDTH] = rca_so;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 0;
        end
        else begin
            mul_out <= rca_so;
        end
    end

endmodule


module rcax #(
    parameter width = 4
) (
    input [width-1:0] A,
    input [width-1:0] B,
    input wire c_i, 

    output [width-1:0] S,
    output c_o
);//把全加器级联起来就构成了 行波进位加法器， 优缺点：。。。
    wire [width:0] cascadeLine; //全加器之间的级联线路
    genvar i;
    generate
        for (i=0; i<width; i=i+1) begin : rca_width
            fullAdder_1 fulladders(
                .a(A[i]),
                .b(B[i]),
                .c_i(cascadeLine[i]),
                .s(S[i]),
                .c_o(cascadeLine[i+1])
            );
        end
    endgenerate
    assign c_o = cascadeLine[width];
    assign cascadeLine[0] = c_i;
endmodule
module fullAdder_1(
    input wire a, b, //两个一位加数字
    input wire c_i,  //进位输入
    output s, c_o
);
    assign s = a ^ b ^ c_i;
    assign c_o = a & b | (a ^ b) & c_i;
endmodule

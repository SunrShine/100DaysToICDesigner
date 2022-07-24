
module mul_8x8_pipline(

    input   wire            clk_mul8x8,
    input   wire            rst_n   ,
    input   wire    [ 7: 0] a       ,
    input   wire    [ 7: 0] b       ,

    output  wire        [ 15: 0] dout

    );
//内部时钟连线
wire mod_clk;
assign mod_clk = clk_mul8x8;


wire [15:0] ab0,ab1,ab2,ab3,ab4,ab5,ab6,ab7;

//使用选择器快速计算每位乘法。
assign ab0 =(b[0] ? a : 0);
assign ab1 =(b[1] ? {a, 1'b0} : 0); 
assign ab2 =(b[2] ? {a, 2'b00} : 0);
assign ab3 =(b[3] ? {a, 3'b000} : 0);
assign ab4 =(b[4] ? {a, 4'b0000} : 0);
assign ab5 =(b[5] ? {a, 5'b00000} : 0);
assign ab6 =(b[6] ? {a, 6'b000000} : 0);
assign ab7 =(b[7] ? {a, 7'b0000000} : 0);


reg [15:0] sum1_0, sum1_1, sum1_2, sum1_3;
reg [15:0] sum2_0, sum2_1;
reg [15:0] sum3_0; 


//第一级加法
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum1_0    <=  0;
    else
        sum1_0    <=  ab0 + ab1;
end
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum1_1    <=  0;
    else
        sum1_1    <=  ab2 + ab3;
end
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum1_2    <=  0;
    else
        sum1_2    <=  ab4 + ab5;
end
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum1_3    <=  0;
    else
        sum1_3    <=  ab6 + ab7;
end

//第二级加法
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum2_0    <=  0;
    else
        sum2_0    <=  sum1_0 + sum1_1;
end
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum2_1    <=  0;
    else
        sum2_1    <=  sum1_2 + sum1_3;
end

////第3级加法
always @ (posedge mod_clk or negedge rst_n)begin
    if (rst_n == 1'b0)
        sum3_0    <=  0;
    else
        sum3_0    <=  sum2_1 + sum2_0;
end

assign dout = sum3_0;



endmodule


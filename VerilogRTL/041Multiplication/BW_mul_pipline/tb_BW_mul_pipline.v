module tb_BW_mul_pipline;
parameter WIDTH = 16;


    reg clk ,rst_n;
    reg [WIDTH-1:0] x1, x2;
    wire [2*WIDTH-1:0] pout;

    //输出计算得到的高16位数据
    wire [WIDTH-1:0] mul_out;


    initial begin
        clk = 0;
        rst_n = 1;
        x1 = 2;
        x2 = 2;
        
        #1 rst_n = 0;
        #2 rst_n = 1;

        repeat (5) begin
            #20 x1 = x1 + 10;
        end

        repeat (5) begin
            #20 x1 = x1 - 100;
        end
    end


    BW_mul_pipline #(
        .WIDTH(WIDTH)
    ) mul_pip (
        .clk(clk),
        .rst_n(rst_n),
        .X_wire(x1),
        .Y_wire(x2),
        .P(pout),
        .mul_out(mul_out)
    );

    always #5 clk = ~clk;

endmodule

//vlog .\tb_BW_mul_pipline.v .\BW_mul_pipline.v
//  vsim .\tb_BW_mul_pipline.v   -voptargs=+acc
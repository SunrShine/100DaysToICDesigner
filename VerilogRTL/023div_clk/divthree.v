
// 二选一多路选择器
module mux2(a, b, sel, out);    

    input sel;                  
    input a;
    input b;
    output out;
    
    assign out = (sel == 1)?a:b;
 
endmodule


//三分频电路
module divthree(
    input wire clk,  //时钟
    input wire rst_n,  //复位
    output wire div_three  //三分频输出
);
    reg [1:0] cnt;      //分频计数器
    reg div_clk1;
    reg div_clk2;

    //计数器从0计数到3并循环
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
        end
        else if(cnt == 2)begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end

    //每当cnt计数到0的时候翻转
    always @(posedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk1 <= 0;
        end
        else if(cnt == 0)begin
            div_clk1 <= ~div_clk1;
        end
        else
            div_clk1 <= div_clk1;
    end

    //每当cnt计数到2的时候翻转
    always @(negedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk2 <= 0;
        end
        else if(cnt == 2)begin
            div_clk2 <= ~div_clk2;
        end
        else
            div_clk2 <= div_clk2;
    end

    
assign div_three = div_clk2 ^ div_clk1;

endmodule
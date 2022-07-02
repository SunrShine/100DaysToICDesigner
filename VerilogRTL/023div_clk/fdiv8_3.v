module fdiv8_7 (
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);

parameter fd8_7 = 8'd87;
parameter c_89 = 8'd24;  // 8/9时钟切换点
parameter t_even = 5'd8;
parameter t_odd= 5'd9 ;

reg [3:0] cnt_clk;
reg [6:0] cnt_cyc;
reg div_flag;
reg clk_out_r;


//总循环计数开始：
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt_cyc <= 0;      
    end
    else begin
        cnt_cyc <= (cnt_cyc == (fd8_7-1))? 0 : cnt_cyc + 1;
    end
end
//8，9周期切换表示生成，
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        div_flag <= 0;     
    end
    else begin
        div_flag <= (cnt_cyc == (fd8_7-1) || cnt_cyc == (c_89-1))?
            ~div_flag : div_flag;
    end
end


//分别进行8，9周期的计数
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt_clk <= 0;
    end
    else if (~div_flag) begin
        cnt_clk <= (cnt_clk == (t_even-1))? 0 : cnt_clk + 1;
    end
    else begin
        cnt_clk <= (cnt_clk == (t_odd-1))? 0 : cnt_clk + 1;
    end
end

//偶数分频
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        clk_out_r <= 0;
    end
    else if(~div_flag) begin
        clk_out_r <= (cnt_clk < t_even>>1)? 1 : 0;
    end
end
//奇数分频
always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        clk_out_r <= 0;
    end
    else if(div_flag)  begin
        clk_out_r <= (cnt_clk < t_odd>>1)? 1 : 0;
    end
end


endmodule //fdiv8_3
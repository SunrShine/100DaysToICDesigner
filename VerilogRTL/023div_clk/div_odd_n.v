module div_odd_n(
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);

reg [2:0] cnt_p, cnt_n;

reg clk_p, clk_n;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        cnt_p <= 0;
        clk_p <= 1;
    end
    else begin
        cnt_p <= cnt_p + 1;

        if (cnt_p == 1 ||cnt_p == 4) begin
            clk_p <= ~clk_p;
        end
        if (cnt_p == 4) begin
            cnt_p <= 0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        cnt_n <= 0;
        clk_n <= 1;
    end
    else begin
        

        if (cnt_n == 0 ||cnt_n == 2) begin
            clk_n <= ~clk_n;
        end
        if (cnt_n == 4) begin
            cnt_n <= 0;
        end

        cnt_n <= cnt_n + 1;
    end
end

reg [2:0] cnt_t;
reg clk_t;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        cnt_t <= 0;
        clk_t <= 1;
    end
    else begin
        
        if (cnt_t<5) begin
            cnt_t <= cnt_t + 1;
            if (cnt_t == 1 ||cnt_t == 4) begin
                clk_t <= ~clk_t;
            end
        end
        else begin
            cnt_t <= 0;
        end       
    end
end

// reg a,b;
// always @(posedge clk or negedge rst_n) begin
//     a <= 1;
//     a <= 0;
//     b <= 0;
//     b <= 1;
    
// end


assign div_clk = clk_p ^ clk_n;

endmodule
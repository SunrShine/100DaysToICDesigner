module fdiv5_3 (
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);

reg [3:0] cnt1, cnt2;

reg clk_out_temp;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt1 <=0;
        cnt2 <= 0;
        clk_out_temp <= 0;
    end
    else if(cnt1 < 9)begin
        cnt1 <= cnt1 + 1;
        if (cnt2 < 4) begin
            clk_out_temp <=0;
            cnt2 <= cnt2 +1;

        end
        else begin
            clk_out_temp <= 1;
            cnt2 <= 0;
        end
    end
    else begin
        if (cnt2 < 7) begin
            cnt2 <= cnt2 +1;
            clk_out_temp <= 0;
        end
        else begin
            cnt2 <= 0;
            clk_out_temp <= 1;
            cnt1 <= 0;
        end
    end
end

assign div_clk = clk_out_temp;

endmodule //fdiv5_3
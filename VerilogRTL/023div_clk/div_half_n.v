
//分频，每过M个周期，生成0.5个时钟周期的高电平

module div_half_n #(
    parameter M = 2
) (
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);
    
reg [3:0] cnt1, cnt2;
reg div1, div2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt1 <= 0;
        div1 <= 1;
    end
    else begin
        if (cnt1 == 2*M ) begin
            cnt1 <= 0;
            div1 <= ~div1;
        end
        else begin
            cnt1 <= cnt1 + 1;
            if (cnt1 == M) begin
                div1 = ~div1;
            end
        end
    end
end

always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt2 <= 0;
        div2 <= 1;
    end
    else begin
       

        if (cnt2 == 2*M ) begin
            cnt2 <= 0;
        end
        else begin
            cnt2 <= cnt2 + 1;
            if (cnt2 == 0 || cnt2 == 2) begin
                div2 <= ~div2;
            end
        end
    end
end

assign div_clk = div1 & div2;

endmodule


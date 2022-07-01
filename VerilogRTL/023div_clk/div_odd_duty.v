
//根据占空比计算
module div_odd_duty(
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);
reg [15:0] counter;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        counter <= 0;
        div_clk <= 0;
    end
    else begin
        if (counter == 56818) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end
end

assign clk_div = counter[15];
endmodule 
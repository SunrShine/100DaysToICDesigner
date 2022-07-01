module div_any_even(
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);
reg [3: 0] cnt;
reg clk_x;

always @(posedge clk or negedge rst_n) begin
    if( !rst_n)begin
        cnt <= 0;
        clk_x <= 0;
        div_clk <= 0;
    end
    else  begin
        if (cnt == 5) begin
            cnt <= 0;
            clk_x <= ~clk_x;
        end
        else if (cnt == 1) begin
            clk_x <= ~clk_x;
        end
        cnt <= cnt +1;
    end
end
assign div_clk = clk_x;
    
endmodule
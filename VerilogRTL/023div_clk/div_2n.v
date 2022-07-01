module div_2n 
#(  parameter cntN = 2,
    parameter N = 1<<N)
(
    input wire  clk,
    input wire  rst_n,
    output wire div_clk
);

reg [cntN-1 : 0] cnt;
reg clk_n;

always @(posedge clk or negedge rst_n) begin
    if( !rst_n)begin
        cnt <= 0;
        clk_n <= 0;
        div_clk <= 0;
    end
    else begin
        if(cnt == 2*N-1 ) begin
            clk_n <= ~clk_n;
        end
        else if (cnt == N-1) begin
            clk_n <= ~clk_n;
        end
        cnt <= cnt + 1;
    end
end

assign div_clk = clk_n;

endmodule
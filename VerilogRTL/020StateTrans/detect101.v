module detect101(
    input wire clk,
    input wire rst_n,
    input wire data,
    output wire flag_101
);
    parameter s0 = 0,s1 = 1, s2 = 2, s3 = 3, s4 = 4;

    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            state <= s0
        end
    end
endmodule
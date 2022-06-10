module ringCounter(
    input clk,
    input rst_n,
    output reg [3:0] cnt
);
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 4'b0001;
        end
        else begin
            cnt <= {cnt[2:0], cnt[3]};
        end
    end
endmodule
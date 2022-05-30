module deserialize (
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg [7:0] data_out
);
    reg [2:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'b0;
            cnt <= 3'b0;
        end
        else begin
            data_out[7-cnt] <= data_in;
            cnt <= cnt + 1'b1;
        end
    end
endmodule
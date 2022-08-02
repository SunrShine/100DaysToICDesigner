module asyn_fifo_syn_WToR
#(parameter ADDR_WIDTH = 6)
(
    input wire read_clk,
    input wire read_rst_n,
    input wire [ADDR_WIDTH:0] write_ptr,
    output reg [ADDR_WIDTH:0] sync_write_to_read
);
    reg [ADDR_WIDTH:0] dff_reg0;

    always @(posedge read_clk or negedge read_rst_n) begin
        if (!read_rst_n) begin
            dff_reg0 <= 0;
            sync_write_to_read <= 0;
        end
        else begin
            dff_reg0 <= write_ptr;
            sync_write_to_read <= dff_reg0;
        end
    end

endmodule
module asyn_fifo_syn_RToW
#(parameter ADDR_WIDTH = 6)
(
    input wire write_clk,
    input wire write_rst_n,
    input wire [ADDR_WIDTH:0] read_ptr,
    output reg [ADDR_WIDTH:0] sync_read_to_write
);
    reg [ADDR_WIDTH:0] dff_reg;

    always @(posedge write_clk or negedge write_rst_n) begin
        if (!write_rst_n) begin
            dff_reg <= 0;
            sync_read_to_write <= 0;
        end
        else begin
            dff_reg <= read_ptr;
            sync_read_to_write <= dff_reg;
        end
    end

endmodule
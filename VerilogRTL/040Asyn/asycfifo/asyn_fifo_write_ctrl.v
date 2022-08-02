module asyn_fifo_write_ctrl
#(
    parameter ADDR_WIDTH = 6
)
(
    input wire write_clk,
    input wire write_rst_n,
    input wire write_ena,
    input wire [ADDR_WIDTH:0] sync_read_ptr, //同步过来的写指针

 
    output reg [ADDR_WIDTH:0] write_ptr,
    output wire [ADDR_WIDTH-1:0] write_addr,
    output reg write_full_reg
);
    reg [ADDR_WIDTH:0] write_bin;
    wire [ADDR_WIDTH:0] write_gray_next;
    wire [ADDR_WIDTH:0] write_bin_next;

    always @(posedge write_clk or negedge write_rst_n) begin
        if (!write_rst_n) begin
            write_ptr <= 0;
            write_bin <= 0;
        end
        else begin
            write_ptr <= write_gray_next;
            write_bin <= write_bin_next;
        end
    end

    wire write_full;
    assign write_full = write_gray_next == { ~sync_read_ptr[ADDR_WIDTH:ADDR_WIDTH-1], sync_read_ptr[ADDR_WIDTH-2:0] }; 
    always @(posedge write_clk or negedge write_rst_n) begin
        if (!write_rst_n) begin
            write_full_reg <= 0;
        end
        else begin
            write_full_reg <= write_full;
        end
    end

    assign write_addr = write_bin[ADDR_WIDTH-1:0];
    assign write_bin_next = write_bin + (write_ena & ~write_full_reg);
    assign write_gray_next = (write_bin_next >> 1) ^ write_bin_next;
endmodule 
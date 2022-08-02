module asyn_fifo_read_ctrl
#(
    parameter ADDR_WIDTH = 6
)
(
    input wire read_clk,
    input wire read_rst_n,
    input wire read_ena,
    input wire [ADDR_WIDTH:0] sync_write_ptr, //同步过来的写指针

    output reg [ADDR_WIDTH:0] read_ptr,  //读指针
    output wire [ADDR_WIDTH-1:0] read_addr, //读地址
    output reg read_empty_reg
);

reg  [ADDR_WIDTH:0] read_bin;
wire [ADDR_WIDTH:0] read_gray_next, read_bin_next;

always@(posedge read_clk or negedge read_rst_n)begin
    if (!read_rst_n) begin
        read_bin <= 0;
        read_ptr <= 0;
    end
    else begin
        read_bin <= read_bin_next;
        read_ptr <= read_gray_next;
    end
end


assign read_bin_next = read_bin + (read_ena & ~read_empty_reg);
assign read_gray_next = (read_bin_next>>1)^read_bin_next;
assign read_addr = read_bin[ADDR_WIDTH-1:0];


    
wire read_empty;
assign read_empty = (read_gray_next == sync_write_ptr);

always @(posedge read_clk or negedge read_rst_n) begin
    if(!read_rst_n)begin
        read_empty_reg <= 0;
    end
    else begin
        read_empty_reg <= read_empty;
    end
end



endmodule
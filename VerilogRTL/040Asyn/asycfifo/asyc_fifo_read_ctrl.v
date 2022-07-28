module asyc_fifo_read_ctrl
#(
    parameter ADDR_WIDTH = 6
)
(
    input wire read_clk,
    input wire read_rst_n,
    input wire read_ena,
    input wire [ADDR_WIDTH:0] sync_write_ptr, //同步过来的写指针

    output reg [ADDR_WIDTH:0] read_ptr,  //读指针
    output wire [ADDR_WIDTH-1:0] read_addr //读地址
);


    
endmodule
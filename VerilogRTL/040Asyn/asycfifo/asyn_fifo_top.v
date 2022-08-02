module asyn_fifo_top
#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 6
)
(
    //write
    input       wire    [DATA_WIDTH-1:0]    write_data,
    output      wire                        write_full,
    input       wire                        write_ena,
    input       wire                        write_clk,
    input       wire                        write_rst_n,

    //read
    output      wire    [DATA_WIDTH-1:0]    read_data,
    input       wire                        read_ena,
    output      wire                        read_empty,
    input       wire                        read_clk,
    input       wire                        read_rst_n
);
    
    wire [ADDR_WIDTH-1:0] w_write_addr, w_read_addr;
    wire [ADDR_WIDTH:0] w_write_ptr, w_read_ptr;
    wire [ADDR_WIDTH:0] w_sync_write_ptr, w_sync_read_ptr;

    //写指针控制
    asyn_fifo_write_ctrl #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) write_ctrl(
        .write_clk(write_clk),
        .write_rst_n(write_rst_n),
        .write_ena(write_ena),
        .sync_read_ptr(w_sync_read_ptr),
        
        .write_ptr(w_write_ptr),
        .write_addr(w_write_addr),
        .write_full_reg(write_full)
    );
    //写指针同步到读时钟域
    asyn_fifo_syn_WToR #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) syn_WToR(
        .read_clk(read_clk),
        .read_rst_n(read_rst_n),
        .write_ptr(w_write_ptr),
        .sync_write_to_read(w_sync_write_ptr)
    );
    //读指针控制
    asyn_fifo_read_ctrl #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) read_ctrl(
        .read_clk(read_clk),
        .read_rst_n(read_rst_n),
        .read_ena(read_ena),
        .sync_write_ptr(w_sync_write_ptr), //同步过来的写指针

        .read_ptr(w_read_ptr),  //读指针
        .read_addr(w_read_addr), //读地址
        .read_empty_reg(read_empty)
    );
    //读指针同步到写时钟域
    asyn_fifo_syn_RToW #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) syn_RToW(
        .write_clk(write_clk),
        .write_rst_n(write_rst_n),
        .read_ptr(w_read_ptr),
        .sync_read_to_write(w_sync_read_ptr)
    );


    asyn_fifo_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) ram(
        .read_data(read_data),
        .write_data(write_data),
        .read_addr(w_read_addr),
        .write_addr(w_write_addr),

        .write_clk(write_clk),
        .write_full(write_full),
        .write_ena(write_ena)
    );


endmodule
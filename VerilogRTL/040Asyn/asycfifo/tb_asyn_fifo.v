
module tb_asyn_fifo;
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 6;

reg write_clk, write_rst_n, write_ena;
reg [DATA_WIDTH-1:0]  write_data;
wire write_full;

reg read_clk, read_rst_n, read_ena;
wire [DATA_WIDTH-1:0] read_data;
wire read_empty;
 

asyn_fifo_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) asyn_fifo1 (
    //write
    .write_data(write_data),
    .write_full(write_full),
    .write_ena(write_ena),
    .write_clk(write_clk),
    .write_rst_n(write_rst_n),

    //read
    .read_data(read_data),
    .read_ena(read_ena),
    .read_empty(read_empty),
    .read_clk(read_clk),
    .read_rst_n(read_rst_n)
);


localparam CLK_PERIOD_write = 10;
localparam CLK_PERIOD_read  = 40;
always #(CLK_PERIOD_write/2) write_clk =  ~write_clk;
always #(CLK_PERIOD_read/2)  read_clk  =  ~read_clk;


initial begin

    write_clk = 0;read_clk =0;
    write_rst_n = 0; read_rst_n = 0;

    #1  write_rst_n <= 1'b1;
        read_rst_n  <= 1'b1;

    #1  write_ena = 1;
        read_ena  = 1;
    //
    write_data = 32'h0;

    repeat(10) begin
        #10 write_data = write_data + 1;
    end
    #10 write_ena = 0;
    
end

endmodule

//vlog .\tb_asyn_fifo.v .\asyn_fifo_top.v .\asyn_fifo_ram.v .\asyn_fifo_read_ctrl.v .\asyn_fifo_write_ctrl.v .\asyn_fifo_syn_RToW.v .\asyn_fifo_syn_WToR.v
//  vsim .\tb_asyn_fifo.v  -voptargs=+acc
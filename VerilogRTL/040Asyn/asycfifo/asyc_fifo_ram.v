module asyc_fifo_ram 
#(
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
)
(
    output wire [DATA_WIDTH-1:0] read_data,
    input wire [DATA_WIDTH-1:0] write_data,
    input wire [ADDR_WIDTH-1:0] read_addr,
    input wire [ADDR_WIDTH-1:0] write_addr,

    input wire write_clk,
    input wire write_full,
    input wire write_ena
);

    localparam DEPTH = 1<<ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] ram[DEPTH-1:0];

    assign read_data = ram[read_addr];

    always @(posedge write_clk) begin
        if (write_ena && !write_full) begin
            ram[write_addr] <= write_data;
        end
    end
endmodule
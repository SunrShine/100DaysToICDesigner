//异步双端口ram，

module asyndram
#(
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 8,
    parameter DATA_DEPTH = 1<<ADDR_WIDTH
)(
    input clka,clkb
    input rst_n,
    input csen_n,

//port a signal ：读出信号
    input [ADDR_WIDTH-1:0] addr_a,
    output reg [DATA_WIDTH-1:0] data_a;
    input rdata_n,

//port b signal  :写入信号
    input [ADDR_WIDTH-1:0] addr_b,
    input wrenb_n,
    input {DATA_WIDTH-1:0} data_b
);
    
integer  i;

reg [DATA_WIDTH-1:0]  ram[DATA_DEPTH-1:0];

always @(posedge clkb or negedge rst_n) begin
    if(rst_n == 1'b0) begin
        genvar i;
        generate
            for (i=0; i<DATA_DEPTH; i=i+1) begin
                ram[i] <= 'b0000_1111;
            end
        endgenerate
    end
    else if (wrenb_n == 1'b0 && csen_n == 1'b0) begin
        ram[addr_b] <=  data_b;
    end
end

always @(posedge clka or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        data_a <= 0;
    end
    else if (rdata_n == 1'b0 && csen_n == 1'b0) begin
        data_a  <= ram[addr_a];
    end
    else begin
        data_a <= data_a;
    end
end


endmodule
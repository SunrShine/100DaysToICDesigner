module Edge_Detect(
    input  wire clk,
    input wire rst_n,
    input wire data,
    output  wire pos_edge,
    output wire neg_edge,
    output wire data_edge
);

reg [1:0] datar;

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        datar <= 2'b00;
    end
    else begin
        datar <= {datar[0], data};
    end
end

assign pos_edge = ~datar[1] & datar[0];
assign neg_edge = datar[1] & ~datar[0];
assign data_edge = pos_edge | neg_edge;  



endmodule
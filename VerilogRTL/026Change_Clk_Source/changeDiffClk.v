
//两个时钟不同时,需要使用两级同步器
module changeDiffClk (
    input  wire clk1,
    input  wire clk0,
    input  wire select,
    input  wire rst_n,
    output  wire outclk 
);

    reg [1:0] out0, out1;

    always @(posedge clk1 or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        out1 <= 0;
    end
    else begin
        out1 <= { out1[0] ,~out0[1] & ~select}; 
    end
    end

    always @(posedge clk0 or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            out0 <= 0;
        end
        else begin
            out0 <= { out0[0] , ~out1[1] & select};
        end
    end

    assign outclk = (out1[1]&clk1) | (out0[1]&clk0);
endmodule
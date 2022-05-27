module simpleRom(
    input wire clk,
    input wire rst_n,
    input wire [7:0] addrs,

    output reg [3:0] data 
);

    reg [3:0] ROM[7:0];

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin  //初始化
            ROM[0] <= 0;
            ROM[1] <= 2;
            ROM[2] <= 4;
            ROM[3] <= 6;
            ROM[4] <= 8;
            ROM[5] <= 10;
            ROM[6] <= 12;
            ROM[7] <= 14;
        end
        else begin
            ROM[0] <= 0;
            ROM[1] <= 2;
            ROM[2] <= 4;
            ROM[3] <= 6;
            ROM[4] <= 8;
            ROM[5] <= 10;
            ROM[6] <= 12;
            ROM[7] <= 14;
            data <= ROM[addrs];
        end
    end

endmodule
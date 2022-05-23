

module DTrigger (
    input wire clk,
    input wire data,
    output reg outq
);


//D触发器使用行为级描述，
always @(posedge clk ) begin
    outq <= data;
end

    
endmodule
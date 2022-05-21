

module DTrigger (
    input wire clk,
    input wire data,
    output reg outq
);



always @(posedge clk ) begin
    outq <= data;
end

    
endmodule
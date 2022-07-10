module tb_sync_fifo;
    
reg clk, rst_n, winc, rinc;
reg [7:0] wdata;

wire wfull, rempty;
wire [7:0] rdata;

initial begin
    
    
end    

always #1 clk = ~clk;   


sfifo  aa(
	.clk(clk)		, 
	.rst_n(rst_n)	,
	.winc(winc)	    ,
	.rinc(rinc)	    ,
	.wdata(wdata)	,

	.wfull(wfull)	,
	.rempty(rempty)	,
	.rdata(rdata)
);

endmodule
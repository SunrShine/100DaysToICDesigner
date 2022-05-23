module counter(
    clk,
    rstn,
    dout);
	input clk,rstn;
	output [7:0]dout;
	

	reg    [7:0]dout;
	wire   [7:0]sum;
    
	assign      sum = dout + 1;//组合逻辑部分
	
	always@(posedge clk or negedge rstn) begin
		if(!rstn)begin
			dout <= 0;
		end	
		else begin
			dout <= sum;
		end	
	end	
endmodule

module test(
	input clka,
	input clkb,
	input rst,
	input en_i,
	input [31:0] data_i,
	output en_o,
	output reg [31:0] data_o
);
	reg req;
	reg ack;
	
	reg req_d0, req_d1;
	reg ack_d0, ack_d1;
	
	reg [31:0] data_d0;
	
	always @(posedge clka or negedge rst) begin
		if(~rst)
			begin
				ack_d0 <= 1'b0;
				ack_d1 <= 1'b0;
			end
		else
			begin
				ack_d0 <= ack;
				ack_d1 <= ack_d0;
			end
	end
	
	always @(posedge clkb or negedge rst) begin
		if(~rst)
			begin
				req_d0 <= 1'b0;
				req_d1 <= 1'b0;
			end
		else
			begin
				req_d0 <= req;
				req_d1 <= req_d0;
			end
	end
	
	always @(posedge clka or negedge rst) begin
		if(!rst)
			req <= 1'b0;
		else
			begin
				if(en_i)
					req <= 1'b1;
				else if(ack_d1)
					req <= 1'b0;
				else
					req <= req;
			end
	end
	
	always @(posedge clka or negedge rst) begin
		if(!rst)
			data_d0 <= 'd0;
		else
			begin
				if(en_i)
					data_d0 <= data_i;
				else if(ack_d1)
					data_d0 <= 'd0;
				else
					data_d0 <= data_d0;
			end
	end
	
	always @(posedge clkb or negedge rst) begin
		if(!rst)
			ack <= 1'b0;
		else
			begin
				if(req_d1)
					ack <= 1'b1;
				else if(!req_d1)
					ack <= 1'b0;
				else
					ack <= ack;
			end
	end
	
	always @(posedge clkb or negedge rst) begin
		if(!rst)
			en_o <= 1'b0;
		else
			begin
				if(req_d1)
					en_o <= 1'b1;
				else if(!req_d1)
					en_o <= 1'b0;
				else
					en_o <= en_o;
			end
	end
	
	always @(posedge clkb or negedge rst) begin
		if(!rst)
			data_o <= 'd0;
		else
			begin
				if(req_d1)
					data_o <= data_d0;
				else
					data_o <= data_o;
			end
	end

endmodule
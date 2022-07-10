`timescale 1ns/1ns

/**********************************RAM************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  
	,input [WIDTH-1:0] wdata      	
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  
	,output reg [WIDTH-1:0] rdata 		
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
	if(wenc)
		RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
	if(renc)
		rdata <= RAM_MEM[raddr];
end 

endmodule  

/**********************************SFIFO************************************/
module sfifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					clk		, 
	input 					rst_n	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output reg				wfull	,
	output reg				rempty	,
	output wire [WIDTH-1:0]	rdata
);
    //生成cnt；
    reg [3:0] cnt;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 4'b0000;
        end
        else begin
            case({w_ena, r_ena})
                2'b00, 2'b11: cnt <= cnt;
                2'b01: if(cnt != 0) cnt <= cnt -1;
                2'b10: if(cnt != DEPTH-1) cnt <= cnt +1;
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            wfull <= 0; 
        end
        else if(cnt == DEPTH-1) begin
            wfull <= 1;
        end
        else begin
            wfull <= 0;
        end
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rempty <= 0; 
        end
        else if(cnt == 0) begin
            rempty <= 1;
        end
        else begin
            rempty <= 0;
        end
    end    


    
    wire w_ena, r_ena;
    assign w_ena = winc && !wfull;
    assign r_ena = rinc && !rempty;
    
    //fifo实现
    reg [3:0] waddr,raddr;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            waddr <= 0;
        end
        else if(w_ena == 1'b1)begin
            waddr <= waddr + 1;
        end
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            raddr <= 0;
        end
        else if(r_ena == 1'b1)begin
            raddr <= raddr + 1;
        end
    end
    
    dual_port_RAM  dram0(
        .wclk(clk),
        .wenc(w_ena),
        .waddr(waddr),  
        .wdata(wdata),      	
        .rclk(clk),
        .renc(r_ena),
        .raddr(raddr),  

        .rdata(rdata) 		
    );   
    
endmodule
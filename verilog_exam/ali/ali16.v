module ali16(
input clk,
input rst_n,
input d,
output reg dout
 );

//*************code***********//
    reg [1:0] rst;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin 
            rst <= 0;
            dout <= 0;
        end
        else if(rst[1] == 1'b1) begin
            dout <= d;
        end
    end
    

    always@(posedge clk or posedge rst_n)begin
            rst <= {rst[0], rst_n};
    end
//*************code***********//
endmodule
module Sync_fifo #(parameter WIDTH = 8) (
    input wire clk,
    input wire rst_n,
    input wire Write_Allow,
	input wire Read_Allow,
    input wire[WIDTH-1 : 0] Write_Data,

    output reg[WIDTH-1 : 0 ] Read_Data,
    output wire Empty_Sig,
	output wire Full_Sig,
);

    parameter DEPTH = 1 << WIDTH;
    reg[WIDTH-1 : 0] count     //计数器，用来判断

    //fifo存储主体，
    reg[WIDTH-1 : 0] Mem[DEPTH-1 : 0];

    //fifo地址寄存器
	reg[WIDTH-1 : 0] Write_Addr;
	reg[WIDTH-1 : 0] Read_Addr;

    wire Write_Enable;
	wire Read_Enable;

    assign Write_Enable = Write_Allow && !Full_Sig;
    assign Read_Enable = Read_Allow && !Empty_Sig;
    
    //地址操作
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            Write_Addr <= 0;
        end
        else if (Write_Enable = 1'b1) begin
            Write_Addr <= Write_Addr + 1'b1;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            Read_Addr <= 0;
        end
        else if (Read_Enable = 1'b1) begin
            Read_Addr <= Read_Addr + 1'b1;
        end
    end
 
   //数据读出和写入操作
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            Read_Data <= 0;
        end
        else if (Read_Enable == 1'b1) begin
            Read_Data <= Mem[Read_Addr];
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if (Write_Enable == 1'b1 && rst_n == 1'b1)
            Mem[Write_Addr] <= Write_Data;
    end

    //通过计数器记录读写操作
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            count <= 0;
        end
        else begin
            case({Write_Allow, Read_Allow})
                2'b00,2'b00: count <= count;
                2'b10: if(count != DEPTH-1) count <= count + 1'b1;
                2'b01: if(count != 0) count <= count - 1'b1;
            endcase
        end
    end

    //设置空信号和满信号
    assign Empty_Sig = (count == 0) ? 1 : 0;
    assign Full_Sig  = (count == 0) ? 1 : 0;
endmodule 



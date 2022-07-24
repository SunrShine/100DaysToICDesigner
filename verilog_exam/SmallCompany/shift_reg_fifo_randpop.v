
module shift_reg_fifo_randpop
#(  parameter DEPTH = 8,
    parameter DATA_W = 32
)
(
    input wire clk,
    input wire rstn,
    
    input wire push,
    input wire pop,
    input wire [DATA_W-1:0] push_data,

    output wire empty,
    output wire full,
    output wire [DATA_W-1:0] pop_data
);
    //定义变量
    reg [DATA_W-1:0] mem[DEPTH-1:0];
    reg [DATA_W-1:0] pop_data_reg;
    reg [3:0] count;
    wire push_ena, pop_ena;
   

    //记录fifo当中元素个数，同时count-1充当先入元素的指针，
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            count <= 0;
        end
        else begin
            case ({push, pop})
            2'b00, 2'b11: count <= count;
            2'b10: if(count != 8) count <= count + 1;
            2'b01: if(count != 0) count <= count - 1;
            endcase
        end

    end
    //根据count计算出空满信号
    assign full  = (count == 8) ? 1:0;
    assign empty = (count == 0) ? 1:0;

    //计算出pop_ena和push_ena,输入信号使能后要在fifo不满不空的情况下才能读写
    assign push_ena = push && (!full);
    assign pop_ena = pop && (!empty);

    //移置，写入fifo，push_ena
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            mem[7] <= 0;
            mem[6] <= 0;
            mem[5] <= 0;
            mem[4] <= 0;
            mem[3] <= 0;
            mem[2] <= 0;
            mem[1] <= 0;
            mem[0] <= 0;
        end
        if (push_ena) begin
            //mem <= {mem[DEPTH-2:0], push_data}; 语法报错
            mem[7] <= mem[6];
            mem[6] <= mem[5];
            mem[5] <= mem[4];
            mem[4] <= mem[3];
            mem[3] <= mem[2];
            mem[2] <= mem[1];
            mem[1] <= mem[0];
            mem[0] <= push_data;
        end
    end

    //--------------乱序pop------------------
    //这个fifo设计的是右边进入左边出去
    //随机pop出一个位置的数据，并把这个位置左边的数据向右移动填补空缺
    //由于硬件不能同时进行左移（填补pop数据的空缺位置）和右移（push新的数据），
    //所以在时钟下降沿进行pop操作。
    integer rand , i;
    always@(negedge clk or negedge rstn)begin
        if(!rstn)begin
            pop_data_reg <= 0;
            rand <= 0;
            i <= 0;
        end
        if(pop_ena)begin
            rand = {$random} % count;  //生成一个在0到count-1范围的随机数,此随机数作为pop的数据地址，进行随机的pop，
            pop_data_reg <= mem[rand];
            for (i=rand; i<DEPTH-1; i=i+1) begin
                mem[i] <= mem[i+1];
            end           
        end
        else begin
            pop_data_reg <= 0;
        end
    end
    assign pop_data = pop_data_reg;
    //--------------------------------------



endmodule

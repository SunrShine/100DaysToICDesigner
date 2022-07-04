/*
请设计状态机电路，实现自动售卖机功能，A饮料5元钱，B饮料10元钱，售卖机可接收投币5元钱和10元钱，每次投币只可买一种饮料，考虑找零的情况。
电路的接口如下图所示。sel信号会先于din信号有效，且在购买一种饮料时值不变。
sel为选择信号，用来选择购买饮料的种类，sel=0，表示购买A饮料，sel=1，表示购买B饮料；
din表示投币输入，din=0表示未投币，din=1表示投币5元，din=2表示投币10元，不会出现din=3的情况；
drinks_out表示饮料输出，drinks_out=0表示没有饮料输出，drinks_out=1表示输出A饮料，drinks_out=2表示输出B饮料，不出现drinks_out =3的情况，输出有效仅保持一个时钟周期；
change_out表示找零输出，change_out=0表示没有找零，change_out=1表示找零5元，输出有效仅保持一个时钟周期。
接口电路图如下：
*/


module autosale(
    input    wire   clk   ,
    input    wire   rst_n ,
    input    wire   sel   ,//sel=0,5$dranks,sel=1,10&=$drinks
    input    wire   [1:0] din   ,//din=1,input 5$,din=2,input 10$
 
    output   reg  [1:0] drinks_out,//drinks_out=1,output 5$ drinks,drinks_out=2,output 10$ drinks
    output	 reg        change_out   
);



//状态传输逻辑设计：这一步的设计主要是设定好各个状态之间的传输条件，即在哪种激励有效时状态发生变化。组合逻辑
parameter s0 = 1'b0;   //贩卖机里没有零钱
parameter s5 = 1'b1;   //贩卖机里有5元零钱
reg curr_state, next_state;  //当前状态，下一次状态

//判断状态变化的组合逻辑：
wire cond_s0Tos5 = (sel == 1) && (din == 2'b01);
wire cond_s5Tos0 = ( (sel == 1) && (din == 2'b01) ) || 
                   ( (sel == 0) && (din == 2'b00) ) || 
                   ( (sel == 1) && (din == 2'b10) );

always @(*) begin
    case (curr_state)
        s0:begin
            if (cond_s0Tos5) begin
                next_state = s5;
            end
            else begin
                next_state = s0;
            end
        end
        s5:begin
            if (cond_s5Tos0) begin
                next_state = s0;
            end
            else begin
                next_state = s5;
            end
        end
        default: next_state = s0;
    endcase
end
    
//同步时序描述状态转移
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        curr_state <= s0;
    end
    else begin
        curr_state <= next_state;
    end
end

//时序逻辑进行进行输出：
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        drinks_out <= 2'b00;
        change_out <= 1'b0;
    end
    else begin
        case (curr_state)
            s0:begin
                change_out <= (!sel && din[1] && !din[0]);
                drinks_out <= {sel && din[1] && !din[0], (!sel&& din[1] && !din[0]) + (!sel && !din[1] && din[0])};
            end
            s5:begin
                change_out <= din[1] && !(sel ^ din[0]);
                drinks_out <= { sel && din[0] , !sel && !(din[1] && din[0]) };
            end
            default:begin
                drinks_out <= 2'b00;
                change_out <= 1'b0;
            end
        endcase
    end
end

endmodule
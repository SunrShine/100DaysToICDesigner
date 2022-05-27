//如果使用EDA，，去掉这个； 
//`include "comparator_1.v"

module comparator_4(
    input	wire [3:0]  A,
	input	wire [3:0]	B,
 
 	output	 wire	ANS2    , //A>B
	output   wire   ANS1    , //A=B
    output   wire   ANS0     //A<B
);
    
wire [3:0] w_ans2, w_ans1, w_ans0; 

//生成4个线比较电路
genvar i;
generate
    for (i=3; i>=0; i=i-1) begin : comp4_gen
        comparator_1 comps_inst(
            .a(A[i]),
            .b(B[i]),
            .ans2(w_ans2[i]), // a>b
            .ans1(w_ans1[i]), // a=b
            .ans0(w_ans0[i])  // a<b
        );
    end
endgenerate

//附加判断逻辑，注意使用门级描述实现。
assign ANS2 =  w_ans2[3] 
                | (w_ans1[3] & w_ans2[2]) 
                | (w_ans1[3] & w_ans1[2] & w_ans2[1])
                | (w_ans1[3] & w_ans1[2] & w_ans1[1] & w_ans2[0]);
assign ANS1 = w_ans1[3] & w_ans1[2] & w_ans1[1] & w_ans1[0];
assign ANS0 = ANS1 ? 0 : ~ANS2; 



endmodule



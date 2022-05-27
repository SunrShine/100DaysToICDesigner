`include "Decoder_3_8.v"    //用eda就注释掉
//使用3-8译码器和必要的逻辑门实现函数, 例如：Fun=(~A)·C+A·B
module decoder38_logFun(
    input wire A, B, C,
    output wire Fun
);
    
    wire       Y0_n   ;  
    wire       Y1_n   ; 
    wire       Y2_n   ; 
    wire       Y3_n   ; 
    wire       Y4_n   ; 
    wire       Y5_n   ; 
    wire       Y6_n   ; 
    wire       Y7_n   ;
    
//实例化3-8译码器， 
    Decoder_3_8 U0(
    .E      (1'b1),
    .A0     (Ci  ), 
    .A1     (B   ),
    .A2     (A   ),
    
    .Y0_n    (Y0_n),  
    .Y1_n    (Y1_n), 
    .Y2_n    (Y2_n), 
    .Y3_n    (Y3_n), 
    .Y4_n    (Y4_n), 
    .Y5_n    (Y5_n), 
    .Y6_n    (Y6_n), 
    .Y7_n    (Y7_n)
    );

//将符合要求的最小项合并
assign Fun = ~(Y1_n & Y3_n & Y6_n & Y7_n);

endmodule
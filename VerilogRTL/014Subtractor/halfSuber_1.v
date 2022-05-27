module halfSuber_1 (
    input wire Subed,  //被减数
    input wire suber,  //减数

    output wire diff,  //减法差值输出
    output wire s_out //减法借位标志输出
);

    
    assign diff = Subed ^ suber;
    assign s_out = (~Subed) & suber;
    
endmodule
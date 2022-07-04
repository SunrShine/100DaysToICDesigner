module tb_huawei5;

reg clk, rst;
reg [3:0] d;    
wire valid_in, dout;



initial begin
    clk = 0;
    rst = 0;
    d = 0;
    #2 rst = 1;

    #7 d = 0;
    #5 d =  1;
    #5 d =  3;
    #5 d =  2;
    
end    

always #1 clk = ~clk;   

    
huawei5 aa(
        .clk(clk),
        .rst(rst),
        .d(d),
        .valid_in(valid_in),
        .dout(dout)
);  


endmodule

// vsim .\tb_huawei5.v -voptargs=+acc 
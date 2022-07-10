module tb_ali16;

reg clk, rst_n, d;

wire dout;

initial begin
    clk = 0;
    rst_n = 0;
    d = 1;
    
    #1 rst_n = 1; 

end

always #5 clk = ~clk;

ali16 aa(
    .clk(clk),
    .rst_n(rst_n),
    .d(d),
    .dout(dout)
 );
    
endmodule


//vlog .\tb_ali16.v .\ali16.v

// vsim .\tb_ali16.v -voptargs=+acc
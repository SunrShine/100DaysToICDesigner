module tb_div_half_n;

reg clk;
reg rst_n;
wire div_clk;


localparam CLK_T = 10;
localparam CLK_TM2 = 20;
localparam CLK_TM3 = 30;


div_half_n  t1(
    .rst_n (rst_n),
    .clk (clk),
    .div_clk(div_clk)
);


initial begin
    rst_n = 'b0;
    # 1;
    rst_n = 'b1;


end


always begin  
    clk = 1;  
    #(CLK_T/2) ;
    clk = 0;  
    #(CLK_T/2) ;
end

endmodule

// vlog .\tb_div_half_n.v ..\..\VerilogRTL\023div_clk\div_half_n.v

//vsim .\tb_div_half_n.v -voptargs=+acc
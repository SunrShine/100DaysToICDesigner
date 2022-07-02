module tb_div_odd_junjie;

reg clk;
reg rst_n;
wire div_clk;


localparam CLK_T = 10;
localparam CLK_TM2 = 20;
localparam CLK_TM3 = 30;




div_odd_junjie  t1(
    .rst_n (rst_n),
    .clk (clk),
    .div_clk(div_clk)
);


initial begin
    rst_n = 'b0;
    # 1;
    rst_n = 'b1;


    repeat(24) begin
        # CLK_TM3;

    end

    //$stop;
end


always begin  
    clk = 1;  
    #(CLK_T/2) ;
    clk = 0;  
    #(CLK_T/2) ;
end

endmodule

//vlog .\tb_div_odd_junjie.v ..\..\VerilogRTL\023div_clk\div_odd_junjie.v

// vsim .\tb_div_odd_junjie.v
module tb_fdiv5_3;
    
reg clk;
reg rst_n;
wire div_clk;


localparam CLK_T = 10;
localparam CLK_TM2 = 20;
localparam CLK_TM3 = 30;



fdiv5_3   t1(
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

endmodule //tb_fdiv5_3


// vlog .\tb_fdiv5_3.v  ..\..\VerilogRTL\023div_clk\fdiv5_3.v

// vsim  .\tb_fdiv5_3.v -voptargs=+acc
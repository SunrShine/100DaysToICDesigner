module tb_fdiv8_7;

reg clk;
reg rst_n;
wire div_clk;

localparam CLK_T = 10;
localparam CLK_TM2 = 20;
localparam CLK_TM3 = 30;



fdiv8_7   t1(
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


endmodule //tb_fdiv8_7


// vlog .\tb_fdiv8_7.v  ..\..\VerilogRTL\023div_clk\fdiv8_3.v

// vsim  .\tb_fdiv8_7.v -voptargs=+acc
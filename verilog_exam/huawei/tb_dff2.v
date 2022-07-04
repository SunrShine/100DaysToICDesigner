module tb_dff2;


reg clk0, clk1, rst_n, select;


wire out00, out01, outclk;


initial begin
    clk0 = 0;
    clk1 = 0;
    rst_n = 0;
    select = 0;

    #2 rst_n = 1;

    #5 select = 0;
    #7 select = 1;
    #6 select = 0;
    #20 select = 1;
    
end    

always #1 clk1 = ~clk1;   

always #2 clk0 = ~clk0;   

dff2  aa(
    .clk1(clk1),
    .clk0(clk0),
    .rst_n(rst_n),

    .select(select),

    .out00(out00), 
    .out01(out01),
    .outclk(outclk)
);


endmodule

//
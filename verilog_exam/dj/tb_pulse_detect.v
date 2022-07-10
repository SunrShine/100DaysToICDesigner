module tb_pulse_detect;
reg clka, clkb, rst_n , sig_a;

wire sig_b;


initial begin
    rst_n =  0;
    clka = 0;
    clkb = 0;
    sig_a = 0;
    #1 rst_n = 1;

    #10  sig_a = 1;
    #4 sig_a = 0;
end

always #2 clka = ~clka;
always #6 clkb = ~clkb;


pulse_detect aa(
    .clka(clka)    ,
   .clkb(clkb)    ,  
    .rst_n(rst_n)       ,
    .sig_a(sig_a)       ,

   .sig_b(sig_b)
);

endmodule

//    vlog .\tb_pulse_detect.v .\pulse_detect.v
//     vsim .\tb_pulse_detect.v -voptargs=+acc
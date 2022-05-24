`timescale 1ns/1ns

module tb_Sync_Pulse_all;



    //快时钟到慢时钟
    parameter clka_period = 5;  
    parameter clkb_period = 10;  
    reg clka, clkb;
    reg rst_n;
    reg pulse_ina;
    
    wire pulse_outb, signal_outb;
    Sync_Pulse_all syncPluse(
    .clka(clka),
    .clkb(clkb),
    .rst_n(rst_n),
    .pulse_ina(pulse_ina),

    .pulse_outb(pulse_outb),
    .signal_outb(pulse_outb)
    );

    initial begin
    $dumpfile("Sync_Pulse_all.vcd");
    $dumpvars(0,tb_Sync_Pulse_all);

    clka = 0;
    clkb = 0;

    rst_n = 0;
    #20 rst_n = 1;

    pulse_ina = 0;
    #30  pulse_ina = 1;
    #10  pulse_ina = 0;

    #80;
    $stop;
    
    end

    always #(clka_period/2) clka <= ~clka; 
    always #(clkb_period/2) clkb <= ~clkb;  

endmodule //testbench

//modelsim仿真命令
//vlib work 建立工作目录“一次就行了”
//vlog .\tb_Sync_Pulse_all.v ..\..\VerilogRTL\021Sync_Pulse\Sync_Pulse_all.v
//vsim .\tb_Sync_Pulse_all.v -voptargs=+acc    
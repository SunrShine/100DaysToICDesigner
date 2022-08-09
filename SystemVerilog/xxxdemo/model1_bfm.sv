interface model1_bfm();
    logic clk;
    logic rst_n;
    logic sel;

    logic flag;

    

    initial begin
         clk=0;
         forever  #10 clk = ~clk;
    end
    task reset();
        rst_n = 0;
        @(posedge clk);
        @(posedge clk);
        rst_n = 1;
    endtask
    task send_data(bit in_data);
        @(posedge clk) sel = in_data; 
    endtask


endinterface //interfacename


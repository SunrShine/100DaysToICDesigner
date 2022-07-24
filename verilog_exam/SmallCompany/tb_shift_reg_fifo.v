module tb_shift_reg_fifo;

parameter DEPTH = 8;
parameter DATA_W = 32;

parameter T = 20;

reg clk, rstn;
reg push, pop;

reg [DATA_W-1:0] push_data;

wire empty,full;
wire [DATA_W-1:0] pop_data;


initial begin
    clk = 0;
    rstn = 1;
    push = 0;
    pop = 0;
    push_data = 32'hffff_ffff;
    #10 rstn = 0;
    #30 rstn = 1;
end

initial begin
    while (push_data > 32'hffff_0000) begin
        #(T) push_data = push_data - 100;
    end
end

initial begin
    #40 push = 0;

    #10 push = 1;
    #110 push = 0;
end


initial begin
    #40 pop = 0;

    #40 pop = 1;
    #40 pop = 0;
end


always #(T/2) clk = ~clk;



shift_reg_fifo #(.DEPTH(DEPTH), .DATA_W(DATA_W)) aa
(
    .clk(clk),
    .rstn(rstn),
    
    .push(push),
    .pop(pop),
    .push_data(push_data),

    .empty(empty),
    .full(full),
    .pop_data(pop_data)
);

endmodule


//vlog  .\tb_shift_reg_fifo.v .\shift_reg_fifo.v

//vsim .\tb_shift_reg_fifo.v -voptargs=+acc
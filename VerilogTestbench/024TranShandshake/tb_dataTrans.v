module tb_dataTrans;

reg clka, clkb;
reg rst_n;

localparam CLK_Ta = 10;
localparam CLK_Tb = 20;

wire connect_req, connect_ack;
wire [3:0] connect_data;
data_sender sender1(
    .clka(clka),
    .rst_n(rst_n),

    .data_ack(connect_ack),
    .data_req(connect_req),
    .data(connect_data)
);

data_receiver receiver1(
    .clkb(clkb),
    .rst_n(rst_n),

    .data_req(connect_req),
    .data_ack(connect_ack),
    .data(connect_data)
);

initial begin
    rst_n = 'b0;
    # 1;
    rst_n = 'b1;

    repeat(24) begin
       

    end

    //$stop;
end

always begin  
    clka = 1;  
    #(CLK_Ta/2) ;
    clka = 0;  
    #(CLK_Ta/2) ;
end
always begin  
    clkb = 1;  
    #(CLK_Tb/2) ;
    clkb = 0;  
    #(CLK_Tb/2) ;
end

endmodule //tb_dataTrans

//  vlog .\tb_dataTrans.v ..\..\VerilogRTL\024TranShandshake\data_receiver.v ..\..\VerilogRTL\024TranShandshake\data_sender.v

module pulse_detect(
    input               clka    ,
    input               clkb    ,  
    input               rst_n       ,
    input               sig_a       ,
 
    output              sig_b
);
     
    reg [2:0] dff_rega;
    always@(posedge clka or negedge rst_n)begin
        if(!rst_n)begin
            dff_rega <= 3'b000;
        end
        else begin
            dff_rega <= {dff_rega[1:0], sig_a};
        end
    end
     
    wire sign_a = dff_rega[2]|dff_rega[1]|dff_rega[0];
     
    reg sig_br;
    always@(posedge clkb or negedge rst_n)begin
        if(!rst_n)begin
            sig_br <= 0;
        end
        else if(sign_a == 1'b1) begin
            sig_br <= 1;
        end
        else begin
            sig_br <= 0;
        end
    end
     
    assign sig_b = sig_br;
endmodule
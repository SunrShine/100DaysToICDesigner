module DLatch (
    input wire R,  //复位
    input wire S,   //置位
    input wire C,  //使能
    output reg Q,
    output reg Q_n
);
    
always @(*) begin
    if (~S & ~R) begin
        Q <= Q;
        Q_n <= Q_n;
    end
    else if (S & ~R) begin
        Q <= 1;
        Q_n <= 0;
    end 
    else if(~S & R)begin
        Q <= 0;
        Q_n <= 1;
    end
    else begin
        Q <= 0;
        Q_n <= 0;
    end
end

endmodule


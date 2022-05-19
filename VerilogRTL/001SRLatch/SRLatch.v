module SRLatch (
    input wire R,  //复位
    input wire S,   //置位
    output wire Q,
    output wire Q_n
);
    

   nor nor1(Q, R, Q_n); 
   nor nor2(Q_n, S, Q); 

endmodule


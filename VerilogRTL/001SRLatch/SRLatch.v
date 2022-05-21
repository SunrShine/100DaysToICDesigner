module SRLatch (
    input wire R,  //复位
    input wire S,   //置位
    output wire Q,
    output wire Q_n
);
    
    wire q, nq;

   nor nor1(Q, R, nq); 
   nor nor2(Q_n, S, q); 

    assign Q = q;
    assign Q_n =Q_n;
endmodule

 git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
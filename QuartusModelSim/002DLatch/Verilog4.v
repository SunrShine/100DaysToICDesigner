module Verilog4 (
    
    input wire D,  //d 为 S ； ~d 为 R
    input wire C,  //使能
    output wire Q,
    output wire Q_n
);
    
    wire   nd, wnr,wns,wq,wnq;

    not  not1(nd, D);

    and  and1(wns, nd, C);
    and  and2(wnr, D, C);

    nor  nor1(wq, wns, wnq );
    nor  nor2(wnq, wnr, wq);

    assign Q = wq;
    assign Q_n = wnq;





endmodule


module DLatch (
    input wire D, //d 为 S ； ~d 为 R
    input wire C,  //使能低电平有效
    output wire Q,
    output wire Q_n
);
    //注意声明的每一个wire变量都是对应电路图当中的一条线的。
    wire   nd, wnr,wns,wq,wnq;

    not  not1(nd, D);

    and  and1(wns, nd, C);
    and  and1(wnr, d, C);

    nor  nor1(wq, wns, wnq );
    nor  nor2(wnq, wnr, wq);

    assign Q = wq;
    assign Q_n = wnq;


/*
不带时钟的always模块生成组合逻辑电路，
可用来生成 latch 代码如下：

always @(*)begin
    if(enable)
        Q <= data;
    else 
        Q <= Q;
end


*/


endmodule


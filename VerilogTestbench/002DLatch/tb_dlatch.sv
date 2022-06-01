//运行一些SystemVerilog的基本数据类型以及命令。


`default_nettype none

module tb_dlatch;
    //顶层模块的壳子
    reg  D, C;
    wire Q, Q_n;
    DLatch sr(
        .D(D),
        .C(C),
        .Q(Q),
        .Q_n(Q_n)
    );


initial begin
    $dumpfile("tb_dlatch.vcd");
    $dumpvars(0, tb_dlatch);

end


//---------------------------systemverilog------------------------------//
//数组
bit [31:0] src[5] = '{0,1,2,3,4};
bit [31:0] dst[5] = '{5,4,3,2,1};
bit[3:0][7:0] bytes;
initial begin
    //数组比较

    if (src == dst) begin
        $$display("src==dst");
    end
    else begin
        $$display("src!=dst");
    end

    dst = src;
    src[0] = 5;

    $display("src %s dst", (src==dst)?"==":"!=");
    $display("src[1:4] %s dst[1:4]", (src[1:4]==dst[1:4])?"==":"!=");

    //合并数组
    bytes = 32'hfab7_998b;
    $$display(bytes, bytes[3], bytes[3][7]);

    
end

//动态数组
int dyn[];
initial begin
    dyn = new[5];
    foreach (dyn[i]) begin
        dyn[i] = i;
    end
    dyn = new[20](dyn);
    dyn.delete;
end

//队列
initial begin
    int q[$] = {1,2,6};
    q.push_front(6);
    int j = q.pop_back(8);
    q.push_back(6);
    q = {q[0], j ,q[1:$]};
    foreach (q[i]) begin
        $display(q[i]);
    end
end


interface abr_if(input bit clk);
    logic [1:0] grant, request;
    logic rst;

    modport TEST (
    input grant, clk,
    output request, rst);

endinterface
    
endmodule


`default_nettype wire





//modelsim  命令 
// vlib work
// vlog -sv  .\tb_dlatch.sv  ..\..\VerilogRTL\002DLatch\DLatch.v
// vsim tb_dlatch  -voptargs=+acc
module  ahb_socket_top #( 
    parameter DATAWIDTH = 16,
    parameter ADDRWIDTH = 6
)1
(
    input wire hclk, //总线时钟
    input wire hrst_n,//复位信号
    input wire enable, //top-->master ，使能信号，决定是否进行读写
    input wire [DATAWIDTH-1:0] data_input,//top-->master, 输入数据
    input wire [ADDRWIDTH-1:0] addr_input, //top-->master，输入地址
    
    input wire wr,  //top-->master, 读写控制信号

    output wire [DATAWIDTH-1:0] data_output//master-->top,master读出的数据
);



endmodule
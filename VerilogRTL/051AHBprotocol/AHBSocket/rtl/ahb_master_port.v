module ahb_master_port#( 
    parameter DATAWIDTH = 16,
    parameter ADDRWIDTH = 16
)
(
    //ahb_master_port,
    input wire [DATAWIDTH-1:0] write_input,    //写入数据
    input wire [ADDRWIDTH-1:0] addr_input,    //对应读写的地址
    input wire write_read,                    //读写标志
    input wire length_input,                  //读写数据长度

    output wire [DATAWIDTH-1:0] read_output,  //读出数据
    output wire write_read_ready;             //表示本次传输是否完成
    
    //总线功能信号
    input wire hclk,
    input wire hrst_n,
      //对应port输出
    input wire hready,                        //拉高表示传输结束，
    input wire [DATAWIDTH-1:0] hrdata,        //从slave读出的数据
      //对应port输入
    output reg [ADDRWIDTH-1:0] haddr,         //读写对应的地址
    output reg hwrite,                        //读写控制，1写0读
    output reg [DATAWIDTH-1:0] hwdata,        //写入slave的数据
      //传输状态机判断
    input wire [1:0] hresp,                   //传输响应类型
    output reg [1:0] htrans,                  //传输类型

    //总线控制信号
    input wire hgrantx,
    output wire hbuusreqx,
    output wire hlockx
);
  //连线,组合逻辑输出，
  assign write_read_ready = hready;
  assign read_output = hrdata;
  //连线，reg寄存器在下一个周期输出，
  always @(posedge hclk or negedge hrst_n) begin
    if (~hrst_n) begin
      haddr <= 0;
      hwrite <= 0;
      hwdata <= 0;
    end
    else begin
      haddr <= ;
      hwrite <= ;
      hwdata <= ;
    end
  end       

  //读写状态设计。
  parameter IDEL   = 2'b00;
  parameter BUSY   = 2'b01;
  parameter NONSEQ = 2'b10;
  parameter SEQ    = 2'b11;

  reg [1:0] next_trans;
  always @(posedge hclk or negedge hrst_n) begin
    if(~hrst_n)begin
      htrans <= IDEL;
    end
    else begin
      htrans <= next_trans;
    end
  end

  always@(*)begin
    case (htrans)
      IDEL: next_trans = hready ?  : BUSY ;
    endcase
  end

endmodule
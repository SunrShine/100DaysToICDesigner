# 关于本项目 

本人目前集成电路研二在校生一枚，正在找工作刷verilog题，这里吧这些题记录下了，并简单写了一些测试文件与大家分享，鉴于本人才疏学浅，欢迎各位大佬批评指正。

# 如何使用
本人使用iverlog + vscode进行编写测试。使用vivado或者quartus应该也是可以的。
    PS：文件iverlogRun.bat 是为了方便写的命令行脚本。



# modelsim 常用的指令
vlib work  ： 当前目录建立工作文件夹

vlog ``.\sim\tb_top.v``   ``.\src\top.v``  : 仿真编译

vsim ``tb_top`` -voptargs=+acc  ：  开始仿真


# iVerilog 常用的指令

  .\tb_


vvp   $ fileName $

gtkwave %target%.vcd  查看对应的vcd波形图
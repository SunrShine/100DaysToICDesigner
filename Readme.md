# 关于本项目 

卷，加速

ps:写testbench真的折磨
# 如何使用

使用iverlog + vscode进行编写测试。使用vivado或者quartus应该也是可以的。
    PS：文件iverlogRun.bat 是为了方便写的命令行脚本。
使用questasim ,modelsim 等软件仿真



# iVerilog 常用的指令 （不支持SystemVerilog，测试不香了)
```bush
iverilog -o ...\wave.SunR ...\tb_Sync_Pulse_all.v ...\Sync_Pulse_all.v
vvp  ...\wave.SunR  
```
vvp  -n  $ fileName $

gtkwave %target%.vcd  查看对应的vcd波形图


# modelsim 常用的指令
vlib work  ： 当前目录建立工作文件夹

vlog ``.\sim\tb_top.v``   ``.\src\top.v``  : 仿真编译

vsim ``tb_top`` -voptargs=+acc  ：  开始仿真

# Systemverilog UVM仿真
## 使用modelsim 
```bush
//设置临时环境变量


```
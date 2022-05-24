set /p dir=Please input the dir of testbench.v which you want to simulation.

cd %dir%

rem 使用以下命令进行测试编译，参考iverilog教程

iverilog -o wave.SunR  .\tb_


vvp wave.SunR

rem  use gtkwave %target%.vcd  查看对应的vcd波形图



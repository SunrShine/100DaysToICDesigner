 
## 多输入门
多输入门只有单个输出，有单个或多个输入端。Verilog 内置多输入门如下：
and(与门） nand(与非门） or(或门） nor(或非门） xor(异或门) xnor(同或门)
``` Verilog
  //basic gate instantiation
   and  a1      (OUTX,  IN1, IN2) ;
   nand na1     (OUTX1, IN1, IN2) ;

   or   or1     (OUTY,  IN1, IN2) ;
   nor  nor1    (OUTY1, IN1, IN2) ;
   //3 input
   xor xor1     (OUTZ,  IN1, IN2, IN3) ;
   //no instantiation name
   xnor         (OUTZ1, IN1, IN2) ;

```

## 多输出门
多输出门只有单个输入，有单个或多个输出端，又可称之为 buffer，起缓冲、延时作用。
内置多输出门如下： 
buf(缓冲器)  not(非门)
``` Verilog
   //buf
   buf buf1     (OUTX2, IN1) ;
   //2 output
   buf buf2     (OUTY2, OUTY3, IN2) ;
   //no instantiation name
   not          (OUTZ3, IN3) ;
```

## 三态门
Verilog 中还提供了 4 个带有控制端的 buffer 门单元，称为三态门。只有当控制信号有效时，数据才能正常传递，否则输出为高阻抗状态 Z。
实例化时，三态门第一个端口为输出端，第二个端口为数据输入端，第三个端口为控制输入端。例化时信号排列顺序要一致。
三态门不支持输出端口超过 1 个，但例化时可以不指定实例的名字。

```Verilog
   //tri
   bufif1 buf1     (OUTX, IN1, CTRL1) ;
   bufif0 buf2     (OUTY, IN1, CTRL2) ;
   notif1 buf3     (OUTZ, IN1, CTRL3) ;
   //no instantiation name
   notif0          (OUTX1, IN1, CTRL4) ;
```



## 门级建模代码很麻烦不宜读，因此一般使用行为级建模
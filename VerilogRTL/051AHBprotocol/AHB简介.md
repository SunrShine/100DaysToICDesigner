

## 1简介
AHB 总线规范是AMBA总线规范的一部分，
AMBA总线规范是ARM公司提出的总线规范，被大多数SoC设计采用，它规定了AHB (Advanced High-performance Bus)、ASB (Advanced System Bus)、APB (Advanced Peripheral Bus)。

AHB用于``高性能、高时钟频率的系统结构``，典型的应用如ARM核与系统内部的高速RAM、NAND FLASH、DMA、Bridge的连接。

APB用于``连接外部设备，对性能要求不高``，而考虑低功耗问题。ASB是AHB的一种替代方案。

### 1.1 AHB总线架构
AHB可以成为一个完整独立的SOC芯片的骨架，将芯片的各个模块连接起来，处理各个模块之间的通信。

module comparator_1(
    input wire a, b,

    output	 wire	 ans2    , //A>B
	output   wire    ans1    , //A=B
    output   wire    ans0      //A<B
);


//真值表
/*    
A	B	F(A>B)	F(A<B)	F(A=B)
0	0	0	0	1
0	1	0	1	0
1	0	1	0	0
1	1	0	0	1
*/

/*运算符-优先级

!  、 ~	最高
*  、 / 、%	次高
+ 、 -	

优先级依次降低
< 、 <= 、 > 、 >= 
== 、 != 、 === 、 !==
&
^ 、 ^~
|
&&

||	次低
？	最低
*/

//门级电路的实现，
assign ans2 = a & ~b;
assign ans1 = a&b | ~a&~b;
assign ans0 = ~a & b;

endmodule